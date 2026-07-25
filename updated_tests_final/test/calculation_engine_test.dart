import 'package:flutter_test/flutter_test.dart';
import 'package:electrician_simulator_app/data/calculators/calculation_engine.dart';
import 'package:electrician_simulator_app/data/repositories/app_repository.dart';

void main() {
  test('Phase 2C exposes at least 20 implemented calculators', () {
    expect(AppRepository.calculators.length, greaterThanOrEqualTo(20));
    for (final calculator in AppRepository.calculators) {
      expect(
        () => CalculationEngine.calculate(
          calculator,
          _sampleInputs(calculator.id),
        ),
        returnsNormally,
        reason: 'Calculator ${calculator.id} should have working calculation logic',
      );
    }
  });

  test('power calculator uses correct reactive power square root formula', () {
    final calculator = AppRepository.calculators.firstWhere((c) => c.id == 'power_calc');
    final result = CalculationEngine.calculate(calculator, {'voltage': 230, 'current': 10, 'pf': 0.8});
    expect(result['apparent_power'], '2300 VA');
    expect(result['real_power'], '1840 W');
    expect(result['reactive_power'], '1380 VAR');
  });

  test('voltage divider and LED savings produce expected outputs', () {
    final divider = AppRepository.calculators.firstWhere((c) => c.id == 'voltage_divider');
    expect(CalculationEngine.calculate(divider, {'vin': 12, 'r1': 1000, 'r2': 1000})['vout'], '6 V');

    final led = AppRepository.calculators.firstWhere((c) => c.id == 'led_savings');
    final result = CalculationEngine.calculate(led, {
      'old_watts': 60,
      'new_watts': 10,
      'quantity': 10,
      'hours_per_day': 5,
      'tariff': 50,
    });
    expect(result['monthly_kwh_saved'], '75 kWh/month');
    expect(result['monthly_cost_saved'], 'Rs. 3750 /month');
  });
}

Map<String, double> _sampleInputs(String calculatorId) {
  switch (calculatorId) {
    case 'ohms_law':
      return {'voltage': 12, 'current': 2};
    case 'power_calc':
      return {'voltage': 230, 'current': 10, 'pf': 0.8};
    case 'voltage_drop':
      return {'current': 20, 'length': 30, 'resistance': 7.41, 'supply_voltage': 230};
    case 'cable_size':
      return {'current': 20};
    case 'motor_flc':
      return {'power': 7.5, 'voltage': 400, 'pf': 0.85, 'efficiency': 90};
    case 'transformer_size':
      return {'load': 80, 'pf': 0.8, 'margin': 25};
    case 'solar_array':
      return {'daily_energy': 10, 'sun_hours': 5.5, 'system_eff': 75, 'panel_watt': 550};
    case 'breaker_size':
      return {'load_current': 16, 'multiplier': 1.25};
    case 'conduit_fill':
      return {'conduit_diameter': 25, 'cable_diameter': 6, 'cable_count': 4};
    case 'led_savings':
      return {'old_watts': 60, 'new_watts': 10, 'quantity': 10, 'hours_per_day': 5, 'tariff': 50};
    case 'battery_bank':
      return {'energy_kwh': 5, 'system_voltage': 48, 'battery_ah': 100, 'dod': 80, 'efficiency': 90};
    case 'voltage_divider':
      return {'vin': 12, 'r1': 1000, 'r2': 1000};
    case 'ground_resistance':
      return {'soil_resistivity': 100, 'rod_length': 2.4, 'rod_diameter': 16};
    case 'harmonics_thd':
      return {'fundamental': 100, 'harmonic_rms': 12};
    case 'pf_correction':
      return {'kw': 100, 'current_pf': 0.75, 'target_pf': 0.95};
    case 'kw_to_hp':
      return {'kw': 7.5};
    case 'hp_to_kw':
      return {'hp': 10};
    case 'single_phase_current':
      return {'kw': 5, 'voltage': 230, 'pf': 0.9};
    case 'three_phase_current':
      return {'kw': 15, 'voltage': 400, 'pf': 0.85, 'efficiency': 90};
    case 'cable_resistance':
      return {'resistivity': 0.0175, 'length': 100, 'area': 10};
    case 'short_circuit_current':
      return {'voltage': 230, 'impedance': 0.2};
    case 'ups_backup_time':
      return {'battery_voltage': 12, 'battery_ah': 200, 'battery_count': 2, 'load_watts': 500, 'efficiency': 85};
    case 'capacitor_bank_size':
      return {'kw': 100, 'current_pf': 0.75, 'target_pf': 0.95, 'voltage': 400, 'frequency': 50};
    case 'earthing_conductor_size':
      return {'fault_current': 5000, 'disconnection_time': 0.4, 'k_factor': 115, 'min_practical': 4};

    case 'energy_kwh': return {'power_kw': 2, 'hours': 5};
    case 'joule_heating': return {'current': 2, 'resistance': 5, 'time': 10};
    case 'kva_to_kw': return {'kva': 10, 'pf': 0.8};
    case 'kw_to_kva': return {'kw': 8, 'pf': 0.8};
    case 'demand_factor': return {'max_demand': 80, 'connected_load': 100};
    case 'load_balancing': return {'l1': 20, 'l2': 22, 'l3': 18};
    case 'inverter_size': return {'load_kw': 5, 'surge_factor': 1.5};
    case 'ev_charger_load': return {'charger_kw': 7.4, 'voltage': 230, 'hours': 3};
    case 'mppt_estimator': return {'panel_vmp': 41, 'panel_imp': 13, 'series_count': 4, 'parallel_count': 2};
    case 'lux_level': return {'lumens': 4000, 'area': 20, 'uf': 0.7};
    case 'room_lumen_method': return {'target_lux': 300, 'area': 20, 'uf': 0.7, 'mf': 0.8};
    case 'cable_power_loss': return {'current': 20, 'loop_resistance': 0.5};
    case 'fuse_size': return {'load_current': 16, 'multiplier': 1.25};
    case 'rcd_leakage_check': return {'leakage_ma': 8, 'rcd_ma': 30};
    case 'cable_tray_fill': return {'tray_width': 100, 'tray_depth': 50, 'cable_area': 1000};
    case 'earth_electrode_parallel': return {'single_rod': 20, 'rod_count': 4, 'utilization': 0.75};
    case 'awg_to_mm2': return {'awg': 12};
    case 'mm2_to_awg': return {'area': 2.5};
    case 'resistor_color_numeric': return {'digit1': 1, 'digit2': 0, 'multiplier': 3, 'tolerance': 5};
    case 'capacitor_code': return {'code': 104};
    case 'transformer_current': return {'kva': 100, 'voltage': 400, 'phase': 3};
    case 'generator_size': return {'load_kw': 80, 'pf': 0.8, 'margin': 25};
    case 'ct_ratio': return {'primary_current': 250, 'ct_primary': 500, 'ct_secondary': 5};
    case 'frequency_period': return {'frequency': 50};
    case 'temperature_correction': return {'base_ampacity': 100, 'correction_factor': 0.87};
    case 'battery_runtime_dc': return {'voltage': 48, 'ah': 100, 'load_w': 1000, 'dod': 80, 'efficiency': 90};
    default:
      throw ArgumentError('No sample input for $calculatorId');
  }
}
