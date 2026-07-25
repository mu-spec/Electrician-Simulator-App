import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/database_service.dart';
import 'project_detail_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late Future<List<Map<String, dynamic>>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _projectsFuture = DatabaseService.getProjects();
  }

  Future<void> _openEditor([Map<String, dynamic>? project]) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ProjectEditorScreen(project: project)),
    );
    if (saved == true && mounted) setState(_reload);
  }

  Future<void> _openDetail(Map<String, dynamic> project) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailScreen(projectId: project['id'] as int),
      ),
    );
    if (mounted) setState(_reload);
  }

  Future<void> _deleteProject(int id) async {
    await DatabaseService.deleteProject(id);
    if (mounted) setState(_reload);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text(UiText.t(context, 'Job Manager'))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(),
        icon: const Icon(Icons.add),
        label: Text(UiText.t(context, 'New Job')),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          final projects = snapshot.data ?? const <Map<String, dynamic>>[];
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (projects.isEmpty) return const _EmptyProjects();
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: projects.length,
            itemBuilder: (context, index) => _ProjectCard(
              project: projects[index],
              isDark: isDark,
              onTap: () => _openDetail(projects[index]),
              onEdit: () => _openEditor(projects[index]),
              onDelete: () => _deleteProject(projects[index]['id'] as int),
            ),
          );
        },
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _ProjectCard({
    required this.project,
    required this.isDark,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final status = project['status'] as String? ?? UiText.t(context, 'Open');
    final priority =
        project['priority'] as String? ?? UiText.t(context, 'Normal');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.work_outline,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['name'] as String? ??
                          UiText.t(context, 'Untitled Job'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${project['client'] ?? UiText.t(context, 'No client')} • '
                      '${project['site'] ?? UiText.t(context, 'No site')}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _Badge(status, AppTheme.accentGreen),
                        _Badge(priority, AppTheme.accentOrange),
                        _Badge(
                          project['job_type'] as String? ??
                              UiText.t(context, 'General'),
                          AppTheme.accentPurple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text(UiText.t(context, 'Edit')),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(UiText.t(context, 'Delete')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge(this.text, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w700),
    ),
  );
}

class _EmptyProjects extends StatelessWidget {
  const _EmptyProjects();
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.work_outline,
            size: 64,
            color: AppTheme.primaryBlue.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            UiText.t(context, 'No jobs yet'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            UiText.t(
              context,
              'Create a job to track client details, site notes, materials, labor, photos, checklists and invoices.',
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}

class ProjectEditorScreen extends StatefulWidget {
  final Map<String, dynamic>? project;
  const ProjectEditorScreen({super.key, this.project});

  @override
  State<ProjectEditorScreen> createState() => _ProjectEditorScreenState();
}

class _ProjectEditorScreenState extends State<ProjectEditorScreen> {
  late final TextEditingController _name;
  late final TextEditingController _client;
  late final TextEditingController _phone;
  late final TextEditingController _site;
  late final TextEditingController _notes;
  String _status = 'Open';
  String _priority = 'Normal';
  String _jobType = 'General Electrical';

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _name = TextEditingController(text: p?['name'] as String? ?? '');
    _client = TextEditingController(text: p?['client'] as String? ?? '');
    _phone = TextEditingController(text: p?['phone'] as String? ?? '');
    _site = TextEditingController(text: p?['site'] as String? ?? '');
    _notes = TextEditingController(text: p?['notes'] as String? ?? '');
    _status = p?['status'] as String? ?? 'Open';
    _priority = p?['priority'] as String? ?? 'Normal';
    _jobType = p?['job_type'] as String? ?? 'General Electrical';
  }

  @override
  void dispose() {
    _name.dispose();
    _client.dispose();
    _phone.dispose();
    _site.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(UiText.t(context, 'Job name is required.'))),
      );
      return;
    }
    await DatabaseService.saveProject({
      'id': widget.project?['id'],
      'name': _name.text.trim(),
      'client': _client.text.trim(),
      'phone': _phone.text.trim(),
      'site': _site.text.trim(),
      'status': _status,
      'priority': _priority,
      'job_type': _jobType,
      'notes': _notes.text.trim(),
    });
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        UiText.t(context, widget.project == null ? 'New Job' : 'Edit Job'),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(
              labelText: UiText.t(context, 'Job / Project Name'),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _client,
                  decoration: InputDecoration(
                    labelText: UiText.t(context, 'Client'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _phone,
                  decoration: InputDecoration(
                    labelText: UiText.t(context, 'Phone'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _site,
            decoration: InputDecoration(
              labelText: UiText.t(context, 'Site / Location'),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _jobType,
            items:
                [
                      'General Electrical',
                      'House Wiring',
                      'Commercial',
                      'Industrial Panel',
                      'Motor Control',
                      'Solar Install',
                      'Generator/ATS',
                      'Maintenance',
                    ]
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(UiText.t(context, s)),
                      ),
                    )
                    .toList(),
            onChanged: (v) => setState(() => _jobType = v ?? _jobType),
            decoration: InputDecoration(
              labelText: UiText.t(context, 'Job Type'),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _status,
                  items:
                      ['Open', 'Quoted', 'In Progress', 'Waiting', 'Completed']
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(UiText.t(context, s)),
                            ),
                          )
                          .toList(),
                  onChanged: (v) => setState(() => _status = v ?? _status),
                  decoration: InputDecoration(
                    labelText: UiText.t(context, 'Status'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _priority,
                  items: ['Low', 'Normal', 'High', 'Urgent']
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(UiText.t(context, s)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _priority = v ?? _priority),
                  decoration: InputDecoration(
                    labelText: UiText.t(context, 'Priority'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            minLines: 5,
            maxLines: 10,
            decoration: InputDecoration(
              labelText: UiText.t(context, 'Job Notes / Requirements'),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: Text(UiText.t(context, 'Save Job')),
            ),
          ),
        ],
      ),
    ),
  );
}
