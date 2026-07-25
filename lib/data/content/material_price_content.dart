class MaterialPriceItem {
  final String id;
  final String name;
  final String category;
  final String unit;
  final double estimatedPricePkr;
  final String notes;

  const MaterialPriceItem({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.estimatedPricePkr,
    this.notes = '',
  });
}

class MaterialPriceContent {
  /// Pakistan-oriented starter price list for estimates.
  /// Prices are editable after adding to a project and should be verified with
  /// local suppliers before quoting.
  static const List<MaterialPriceItem> items = [
    MaterialPriceItem(id: 'cable_1_5', name: 'Copper Cable 1.5 mm²', category: 'Cable', unit: 'meter', estimatedPricePkr: 95),
    MaterialPriceItem(id: 'cable_2_5', name: 'Copper Cable 2.5 mm²', category: 'Cable', unit: 'meter', estimatedPricePkr: 155),
    MaterialPriceItem(id: 'cable_4', name: 'Copper Cable 4 mm²', category: 'Cable', unit: 'meter', estimatedPricePkr: 250),
    MaterialPriceItem(id: 'cable_6', name: 'Copper Cable 6 mm²', category: 'Cable', unit: 'meter', estimatedPricePkr: 370),
    MaterialPriceItem(id: 'pvc_conduit_20', name: 'PVC Conduit 20 mm', category: 'Conduit', unit: 'meter', estimatedPricePkr: 90),
    MaterialPriceItem(id: 'pvc_conduit_25', name: 'PVC Conduit 25 mm', category: 'Conduit', unit: 'meter', estimatedPricePkr: 130),
    MaterialPriceItem(id: 'switch_1way', name: '1-Way Switch', category: 'Accessories', unit: 'pcs', estimatedPricePkr: 250),
    MaterialPriceItem(id: 'switch_2way', name: '2-Way Switch', category: 'Accessories', unit: 'pcs', estimatedPricePkr: 350),
    MaterialPriceItem(id: 'socket_13a', name: '13A Socket Outlet', category: 'Accessories', unit: 'pcs', estimatedPricePkr: 550),
    MaterialPriceItem(id: 'fan_regulator', name: 'Fan Regulator', category: 'Accessories', unit: 'pcs', estimatedPricePkr: 650),
    MaterialPriceItem(id: 'mcb_6_10', name: 'MCB 6A/10A', category: 'Protection', unit: 'pcs', estimatedPricePkr: 900),
    MaterialPriceItem(id: 'mcb_16_32', name: 'MCB 16A/32A', category: 'Protection', unit: 'pcs', estimatedPricePkr: 1100),
    MaterialPriceItem(id: 'rcd_40a', name: 'RCD/RCCB 40A 30mA', category: 'Protection', unit: 'pcs', estimatedPricePkr: 5500),
    MaterialPriceItem(id: 'db_8way', name: '8-Way Distribution Board', category: 'Distribution', unit: 'pcs', estimatedPricePkr: 4500),
    MaterialPriceItem(id: 'earth_rod', name: 'Copper Bonded Earth Rod', category: 'Earthing', unit: 'pcs', estimatedPricePkr: 4500),
    MaterialPriceItem(id: 'earth_wire_6', name: 'Earth Wire 6 mm²', category: 'Earthing', unit: 'meter', estimatedPricePkr: 320),
    MaterialPriceItem(id: 'contactor_3p', name: '3-Pole Contactor', category: 'Motor Control', unit: 'pcs', estimatedPricePkr: 6500),
    MaterialPriceItem(id: 'overload_relay', name: 'Thermal Overload Relay', category: 'Motor Control', unit: 'pcs', estimatedPricePkr: 4500),
    MaterialPriceItem(id: 'solar_panel_550', name: 'Solar Panel 550W', category: 'Solar', unit: 'pcs', estimatedPricePkr: 33000),
    MaterialPriceItem(id: 'solar_dc_breaker', name: 'Solar DC Breaker', category: 'Solar', unit: 'pcs', estimatedPricePkr: 2500),
    MaterialPriceItem(id: 'labor_helper_day', name: 'Helper Labor', category: 'Labor', unit: 'day', estimatedPricePkr: 2500),
    MaterialPriceItem(id: 'labor_electrician_day', name: 'Electrician Labor', category: 'Labor', unit: 'day', estimatedPricePkr: 4500),
    MaterialPriceItem(id: 'labor_engineer_visit', name: 'Engineer/Supervisor Visit', category: 'Labor', unit: 'visit', estimatedPricePkr: 8000),
  ];

  static List<String> get categories => items.map((item) => item.category).toSet().toList()..sort();
}
