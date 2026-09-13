import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/share_helper.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/content/material_price_content.dart';
import '../../../data/database_service.dart';
import 'invoice_generator_screen.dart';

class ProjectDetailScreen extends StatefulWidget {
  final int projectId;
  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late Future<_ProjectBundle> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = _load();
  }

  Future<_ProjectBundle> _load() async {
    final project = await DatabaseService.getProject(widget.projectId);
    final items = await DatabaseService.getProjectItems(widget.projectId);
    final photos = await DatabaseService.getProjectPhotos(widget.projectId);
    final calculations = await DatabaseService.getProjectCalculations(
      widget.projectId,
    );
    final checklist = await DatabaseService.getChecklistItems(widget.projectId);
    final totals = await DatabaseService.getProjectTotals(widget.projectId);
    return _ProjectBundle(
      project,
      items,
      photos,
      calculations,
      checklist,
      totals,
    );
  }

  Future<void> _addPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (image == null) return;
    await DatabaseService.addProjectPhoto(widget.projectId, image.path);
    if (mounted) setState(_reload);
  }

  Future<void> _addChecklist() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(UiText.t(context, 'Add Checklist Item')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: UiText.t(context, 'e.g. Verify earth continuity'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(UiText.t(context, 'Cancel')),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await DatabaseService.addChecklistItem(
                  widget.projectId,
                  controller.text.trim(),
                );
              }
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              if (mounted) setState(_reload);
            },
            child: Text(UiText.t(context, 'Add')),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  Future<void> _openItemEditor({
    Map<String, dynamic>? item,
    String? initialType,
  }) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectItemEditorScreen(
          projectId: widget.projectId,
          item: item,
          initialType: initialType,
        ),
      ),
    );
    if (saved == true && mounted) setState(_reload);
  }

  Future<void> _openPriceList() async {
    final added = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => MaterialPricePickerScreen(projectId: widget.projectId),
      ),
    );
    if (added == true && mounted) setState(_reload);
  }

  Future<void> _shareSummary(_ProjectBundle bundle) async {
    final project = bundle.project;
    if (project == null) return;
    final buffer = StringBuffer()
      ..writeln(
        '${UiText.t(context, 'Electrician Simulator App')} ${UiText.t(context, 'Job Summary')}',
      )
      ..writeln('${UiText.t(context, 'Project:')} ${project['name']}')
      ..writeln('${UiText.t(context, 'Client:')} ${project['client']}')
      ..writeln('${UiText.t(context, 'Phone:')} ${project['phone'] ?? ''}')
      ..writeln('${UiText.t(context, 'Site:')} ${project['site']}')
      ..writeln(
        '${UiText.t(context, 'Status:')} ${UiText.t(context, '${project['status']}')}',
      )
      ..writeln(
        '${UiText.t(context, 'Priority:')} ${UiText.t(context, '${project['priority'] ?? 'Normal'}')}',
      )
      ..writeln(
        '${UiText.t(context, 'Type:')} ${UiText.t(context, '${project['job_type'] ?? 'General Electrical'}')}',
      )
      ..writeln()
      ..writeln(
        '${UiText.t(context, 'Materials:')} Rs. ${bundle.totals['material']?.toStringAsFixed(0) ?? '0'}',
      )
      ..writeln(
        '${UiText.t(context, 'Labor:')} Rs. ${bundle.totals['labor']?.toStringAsFixed(0) ?? '0'}',
      )
      ..writeln(
        '${UiText.t(context, 'Total Estimate:')} Rs. ${bundle.totals['total']?.toStringAsFixed(0) ?? '0'}',
      )
      ..writeln()
      ..writeln('${UiText.t(context, 'Notes:')} ${project['notes'] ?? ''}');
    await shareText(
      context,
      text: buffer.toString(),
      subject: '${UiText.t(context, 'Job Summary')} - ${project['name']}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FutureBuilder<_ProjectBundle>(
      future: _future,
      builder: (context, snapshot) {
        final bundle = snapshot.data;
        final project = bundle?.project;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (project == null) {
          return Scaffold(
            appBar: AppBar(title: Text(UiText.t(context, 'Project'))),
            body: Center(child: Text(UiText.t(context, 'Project not found'))),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(project['name'] as String? ?? 'Project'),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: bundle == null ? null : () => _shareSummary(bundle),
              ),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InvoiceGeneratorScreen(project: project),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openItemEditor(),
            icon: const Icon(Icons.add),
            label: Text(UiText.t(context, 'Add Item')),
          ),
          body: RefreshIndicator(
            onRefresh: () async => setState(_reload),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _ProjectHeader(
                  project: project,
                  totals: bundle?.totals ?? const {},
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                _ActionGrid(
                  onAddMaterial: () => _openItemEditor(initialType: 'material'),
                  onAddLabor: () => _openItemEditor(initialType: 'labor'),
                  onPriceList: _openPriceList,
                  onPhoto: _addPhoto,
                  onChecklist: _addChecklist,
                  onInvoice: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InvoiceGeneratorScreen(project: project),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionTitle(UiText.t(context, 'Materials & Labor')),
                ...(bundle?.items ?? const <Map<String, dynamic>>[]).map(
                  (item) => _ItemTile(
                    item: item,
                    onTap: () => _openItemEditor(item: item),
                    onDelete: () async {
                      await DatabaseService.deleteProjectItem(
                        item['id'] as int,
                      );
                      if (mounted) setState(_reload);
                    },
                  ),
                ),
                if ((bundle?.items ?? const []).isEmpty)
                  _EmptyHint(
                    UiText.t(
                      context,
                      'No materials/labor yet. Add items or use the Pakistan price list.',
                    ),
                  ),
                const SizedBox(height: 20),
                _SectionTitle(UiText.t(context, 'Safety / Job Checklist')),
                ...(bundle?.checklist ?? const <Map<String, dynamic>>[]).map(
                  (task) => CheckboxListTile(
                    value: (task['is_done'] as int? ?? 0) == 1,
                    title: Text(task['title'] as String? ?? ''),
                    onChanged: (value) async {
                      await DatabaseService.setChecklistDone(
                        task['id'] as int,
                        value ?? false,
                      );
                      if (mounted) setState(_reload);
                    },
                    secondary: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await DatabaseService.deleteChecklistItem(
                          task['id'] as int,
                        );
                        if (mounted) setState(_reload);
                      },
                    ),
                  ),
                ),
                if ((bundle?.checklist ?? const []).isEmpty)
                  _EmptyHint(
                    UiText.t(
                      context,
                      'No checklist items yet. Add safety or inspection tasks.',
                    ),
                  ),
                const SizedBox(height: 20),
                _SectionTitle(UiText.t(context, 'Site Photos')),
                _PhotosGrid(
                  photos: bundle?.photos ?? const [],
                  onDeleted: () => setState(_reload),
                ),
                const SizedBox(height: 20),
                _SectionTitle(UiText.t(context, 'Linked Calculations')),
                ...(bundle?.calculations ?? const <Map<String, dynamic>>[]).map(
                  (calc) => ListTile(
                    leading: const Icon(
                      Icons.calculate,
                      color: AppTheme.accentGreen,
                    ),
                    title: Text(
                      calc['calculator_name'] as String? ?? 'Calculation',
                    ),
                    subtitle: Text(
                      calc['created_at'] == null
                          ? ''
                          : DateTime.fromMillisecondsSinceEpoch(
                              calc['created_at'] as int,
                            ).toString().split('.').first,
                    ),
                  ),
                ),
                if ((bundle?.calculations ?? const []).isEmpty)
                  _EmptyHint(
                    UiText.t(
                      context,
                      'Saved calculations can be linked in future invoice/cost workflows.',
                    ),
                  ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProjectBundle {
  final Map<String, dynamic>? project;
  final List<Map<String, dynamic>> items;
  final List<Map<String, dynamic>> photos;
  final List<Map<String, dynamic>> calculations;
  final List<Map<String, dynamic>> checklist;
  final Map<String, double> totals;
  const _ProjectBundle(
    this.project,
    this.items,
    this.photos,
    this.calculations,
    this.checklist,
    this.totals,
  );
}

class _ProjectHeader extends StatelessWidget {
  final Map<String, dynamic> project;
  final Map<String, double> totals;
  final bool isDark;
  const _ProjectHeader({
    required this.project,
    required this.totals,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryBlue, AppTheme.primaryLight],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project['name'] as String? ?? 'Project',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${project['client'] ?? ''} • ${project['site'] ?? ''}',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Pill(UiText.t(context, project['status'] as String? ?? 'Open')),
              _Pill(
                UiText.t(context, project['priority'] as String? ?? 'Normal'),
              ),
              _Pill(
                UiText.t(
                  context,
                  project['job_type'] as String? ?? 'General Electrical',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _MoneyBox('Materials', totals['material'] ?? 0)),
              const SizedBox(width: 8),
              Expanded(child: _MoneyBox('Labor', totals['labor'] ?? 0)),
              const SizedBox(width: 8),
              Expanded(child: _MoneyBox('Total', totals['total'] ?? 0)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoneyBox extends StatelessWidget {
  final String label;
  final double value;
  const _MoneyBox(this.label, this.value);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.14),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
        Text(
          'Rs. ${value.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill(this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.16),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _ActionGrid extends StatelessWidget {
  final VoidCallback onAddMaterial;
  final VoidCallback onAddLabor;
  final VoidCallback onPriceList;
  final VoidCallback onPhoto;
  final VoidCallback onChecklist;
  final VoidCallback onInvoice;
  const _ActionGrid({
    required this.onAddMaterial,
    required this.onAddLabor,
    required this.onPriceList,
    required this.onPhoto,
    required this.onChecklist,
    required this.onInvoice,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action(UiText.t(context, 'Material'), Icons.inventory_2, onAddMaterial),
      _Action(UiText.t(context, 'Labor'), Icons.engineering, onAddLabor),
      _Action(UiText.t(context, 'Price List'), Icons.price_check, onPriceList),
      _Action(UiText.t(context, 'Photo'), Icons.camera_alt, onPhoto),
      _Action(UiText.t(context, 'Checklist'), Icons.checklist, onChecklist),
      _Action(
        UiText.t(context, 'Invoice PDF'),
        Icons.picture_as_pdf,
        onInvoice,
      ),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.15,
      ),
      itemBuilder: (_, i) => OutlinedButton(
        onPressed: actions[i].onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(actions[i].icon),
            const SizedBox(height: 6),
            Text(
              actions[i].label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _Action {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _Action(this.label, this.icon, this.onTap);
}

class _ItemTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const _ItemTile({
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final qty = (item['quantity'] as num?)?.toDouble() ?? 0;
    final price = (item['unit_price'] as num?)?.toDouble() ?? 0;
    final isLabor = item['type'] == 'labor';
    return Card(
      child: ListTile(
        leading: Icon(
          isLabor ? Icons.engineering : Icons.inventory_2,
          color: isLabor ? AppTheme.accentPurple : AppTheme.accentGreen,
        ),
        title: Text(item['name'] as String? ?? ''),
        subtitle: Text(
          '${qty.toStringAsFixed(qty.truncateToDouble() == qty ? 0 : 2)} ${item['unit']} × Rs. ${price.toStringAsFixed(0)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rs. ${(qty * price).toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _PhotosGrid extends StatelessWidget {
  final List<Map<String, dynamic>> photos;
  final VoidCallback onDeleted;
  const _PhotosGrid({required this.photos, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty)
      return _EmptyHint(
        UiText.t(
          context,
          'No site photos yet. Use Photo to attach site images.',
        ),
      );
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: photos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (_, index) {
        final photo = photos[index];
        return Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(photo['path'] as String),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 2,
              top: 2,
              child: InkWell(
                onTap: () async {
                  await DatabaseService.deleteProjectPhoto(photo['id'] as int);
                  onDeleted();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProjectItemEditorScreen extends StatefulWidget {
  final int projectId;
  final Map<String, dynamic>? item;
  final String? initialType;
  const ProjectItemEditorScreen({
    super.key,
    required this.projectId,
    this.item,
    this.initialType,
  });

  @override
  State<ProjectItemEditorScreen> createState() =>
      _ProjectItemEditorScreenState();
}

class _ProjectItemEditorScreenState extends State<ProjectItemEditorScreen> {
  late final TextEditingController _name;
  late final TextEditingController _quantity;
  late final TextEditingController _unit;
  late final TextEditingController _unitPrice;
  late final TextEditingController _notes;
  late String _type;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _type = item?['type'] as String? ?? widget.initialType ?? 'material';
    _name = TextEditingController(text: item?['name'] as String? ?? '');
    _quantity = TextEditingController(
      text: ((item?['quantity'] as num?)?.toDouble() ?? 1).toString(),
    );
    _unit = TextEditingController(
      text: item?['unit'] as String? ?? (_type == 'labor' ? 'day' : 'pcs'),
    );
    _unitPrice = TextEditingController(
      text: ((item?['unit_price'] as num?)?.toDouble() ?? 0).toString(),
    );
    _notes = TextEditingController(text: item?['notes'] as String? ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _unit.dispose();
    _unitPrice.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;
    await DatabaseService.saveProjectItem({
      'id': widget.item?['id'],
      'project_id': widget.projectId,
      'type': _type,
      'name': _name.text.trim(),
      'quantity': double.tryParse(_quantity.text) ?? 0,
      'unit': _unit.text.trim().isEmpty ? 'pcs' : _unit.text.trim(),
      'unit_price': double.tryParse(_unitPrice.text) ?? 0,
      'notes': _notes.text.trim(),
    });
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        UiText.t(context, widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SegmentedButton<String>(
            segments: [
              ButtonSegment(
                value: 'material',
                label: Text(UiText.t(context, 'Material')),
              ),
              ButtonSegment(
                value: 'labor',
                label: Text(UiText.t(context, 'Labor')),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _name,
            decoration: InputDecoration(
              labelText: UiText.t(context, 'Item / Work Description'),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quantity,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: UiText.t(context, 'Quantity'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _unit,
                  decoration: InputDecoration(
                    labelText: UiText.t(context, 'Unit'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _unitPrice,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: UiText.t(context, 'Unit Price (Rs.)'),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _notes,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(labelText: UiText.t(context, 'Notes')),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: Text(UiText.t(context, 'Save Item')),
            ),
          ),
        ],
      ),
    ),
  );
}

class MaterialPricePickerScreen extends StatefulWidget {
  final int projectId;
  const MaterialPricePickerScreen({super.key, required this.projectId});

  @override
  State<MaterialPricePickerScreen> createState() =>
      _MaterialPricePickerScreenState();
}

class _MaterialPricePickerScreenState extends State<MaterialPricePickerScreen> {
  String _query = '';
  String _category = 'All';

  List<MaterialPriceItem> get _items {
    var items = MaterialPriceContent.items;
    if (_category != 'All')
      items = items.where((item) => item.category == _category).toList();
    if (_query.trim().isNotEmpty)
      items = items
          .where(
            (item) => item.name.toLowerCase().contains(_query.toLowerCase()),
          )
          .toList();
    return items;
  }

  Future<void> _add(MaterialPriceItem item) async {
    await DatabaseService.saveProjectItem({
      'project_id': widget.projectId,
      'type': item.category == 'Labor' ? 'labor' : 'material',
      'name': item.name,
      'quantity': 1.0,
      'unit': item.unit,
      'unit_price': item.estimatedPricePkr,
      'notes': UiText.t(
        context,
        'Estimated Pakistan market price. Verify locally.',
      ),
    });
    if (mounted)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} ${UiText.t(context, 'added')}'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(UiText.t(context, 'Pakistan Price List'))),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: UiText.t(context, 'Search material or labor...'),
            ),
          ),
        ),
        SizedBox(
          height: 46,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: ['All', ...MaterialPriceContent.categories]
                .map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(UiText.t(context, c)),
                      selected: _category == c,
                      onSelected: (_) => setState(() => _category = c),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _items.length,
            itemBuilder: (_, i) {
              final item = _items[i];
              return Card(
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    '${UiText.t(context, item.category)} • ${UiText.t(context, item.unit)}',
                  ),
                  trailing: Text(
                    UiText.t(
                      context,
                      'Rs. ${item.estimatedPricePkr.toStringAsFixed(0)}',
                    ),
                  ),
                  onTap: () => _add(item),
                ),
              );
            },
          ),
        ),
      ],
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(UiText.t(context, 'Done')),
        ),
      ),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );
}

class _EmptyHint extends StatelessWidget {
  final String text;
  const _EmptyHint(this.text);
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Theme.of(context).dividerTheme.color ?? Colors.transparent,
      ),
    ),
    child: Text(text, style: Theme.of(context).textTheme.bodySmall),
  );
}
