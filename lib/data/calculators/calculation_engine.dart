import 'dart:math' as math;

import '../../models/calculator_model.dart';

class CalculationException implements Exception {
  final String message;
  const CalculationException(this.message);

  @override
  String toString() => message;
}

class CalculationEngine {
  static const List<double> _standardBreakers = [6, 10, 16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400];
  static const List<double> _standardCableSizes = [1.5, 2.5, 4, 6, 10, 16, 25, 35, 50, 70, 95, 120, 150, 185, 240, 300];

  static Map<String, String> calculate(CalculatorModel calculator, Map<String, double> inputs) {
    switch (calculator.id) {
      case 'ohms_law':
        return _ohmsLaw(inputs);
      case 'power_calc':
        return _powerCalc(inputs);
      case 'voltage_drop':
        return _voltageDrop(inputs);
      case 'cable_size':
        return _cableSize(inputs);
      case 'motor_flc':
        return _motorFlc(inputs);
      case 'transformer_size':
        return _transformerSize(inputs);
      case 'solar_array':
        return _solarArray(inputs);
      case 'breaker_size':
        return _breakerSize(inputs);
      case 'conduit_fill':
        return _conduitFill(inputs);
      case 'led_savings':
        return _ledSavings(inputs);
      case 'battery_bank':
        return _batteryBank(inputs);
      case 'voltage_divider':
        return _voltageDivider(inputs);
      case 'ground_resistance':
        return _groundResistance(inputs);
      case 'harmonics_thd':
        return _harmonicsThd(inputs);
      case 'pf_correction':
        return _powerFactorCorrection(inputs);
      case 'kw_to_hp':
        return _kwToHp(inputs);
      case 'hp_to_kw':
        return _hpToKw(inputs);
      case 'single_phase_current':
        return _singlePhaseCurrent(inputs);
      case 'three_phase_current':
        return _threePhaseCurrent(inputs);
      case 'cable_resistance':
        return _cableResistance(inputs);
      case 'short_circuit_current':
        return _shortCircuitCurrent(inputs);
      case 'ups_backup_time':
        return _upsBackupTime(inputs);
      case 'capacitor_bank_size':
        return _capacitorBankSize(inputs);
      case 'earthing_conductor_size':
        return _earthingConductorSize(inputs);

      case 'energy_kwh': return _energyKwh(inputs);
      case 'joule_heating': return _jouleHeating(inputs);
      case 'kva_to_kw': return _kvaToKw(inputs);
      case 'kw_to_kva': return _kwToKva(inputs);
      case 'demand_factor': return _demandFactor(inputs);
      case 'load_balancing': return _loadBalancing(inputs);
      case 'inverter_size': return _inverterSize(inputs);
      case 'ev_charger_load': return _evChargerLoad(inputs);
      case 'mppt_estimator': return _mpptEstimator(inputs);
      case 'lux_level': return _luxLevel(inputs);
      case 'room_lumen_method': return _roomLumenMethod(inputs);
      case 'cable_power_loss': return _cablePowerLoss(inputs);
      case 'fuse_size': return _fuseSize(inputs);
      case 'rcd_leakage_check': return _rcdLeakageCheck(inputs);
      case 'cable_tray_fill': return _cableTrayFill(inputs);
      case 'earth_electrode_parallel': return _earthElectrodeParallel(inputs);
      case 'awg_to_mm2': return _awgToMm2(inputs);
      case 'mm2_to_awg': return _mm2ToAwg(inputs);
      case 'resistor_color_numeric': return _resistorColorNumeric(inputs);
      case 'capacitor_code': return _capacitorCode(inputs);
      case 'transformer_current': return _transformerCurrent(inputs);
      case 'generator_size': return _generatorSize(inputs);
      case 'ct_ratio': return _ctRatio(inputs);
      case 'frequency_period': return _frequencyPeriod(inputs);
      case 'temperature_correction': return _temperatureCorrection(inputs);
      case 'battery_runtime_dc': return _batteryRuntimeDc(inputs);
      default:
        throw CalculationException('Calculator logic is not implemented for ${calculator.name}.');
    }
  }

  static Map<String, String> _ohmsLaw(Map<String, double> x) {
    final hasV = _hasPositive(x, 'voltage');
    final hasI = _hasPositive(x, 'current');
    final hasR = _hasPositive(x, 'resistance');
    final count = [hasV, hasI, hasR].where((v) => v).length;
    if (count < 2) throw const CalculationException('Enter any two values: voltage, current, or resistance.');

    var v = x['voltage'] ?? 0;
    var i = x['current'] ?? 0;
    var r = x['resistance'] ?? 0;

    if (!hasV) v = i * r;
    if (!hasI) i = v / r;
    if (!hasR) r = v / i;
    final p = v * i;

    return {
      'voltage_result': '${_fmt(v)} V',
      'current_result': '${_fmt(i)} A',
      'resistance_result': '${_fmt(r)} Ω',
      'power': '${_fmt(p)} W',
    };
  }

  static Map<String, String> _powerCalc(Map<String, double> x) {
    final v = _positive(x, 'voltage');
    final i = _positive(x, 'current');
    final pf = _bounded(x, 'pf', min: 0, max: 1);
    final apparent = v * i;
    final real = apparent * pf;
    final reactive = math.sqrt(math.max(0, apparent * apparent - real * real));
    return {
      'real_power': '${_fmt(real)} W',
      'apparent_power': '${_fmt(apparent)} VA',
      'reactive_power': '${_fmt(reactive)} VAR',
    };
  }

  static Map<String, String> _voltageDrop(Map<String, double> x) {
    final current = _positive(x, 'current');
    final length = _positive(x, 'length');
    final resistance = _positive(x, 'resistance');
    final supply = _positive(x, 'supply_voltage');
    final vd = (2 * current * length * resistance) / 1000;
    final vdPercent = (vd / supply) * 100;
    return {'vdrop': '${_fmt(vd)} V', 'vdrop_percent': '${_fmt(vdPercent)} %'};
  }

  static Map<String, String> _cableSize(Map<String, double> x) {
    final current = _positive(x, 'current');
    final designCurrent = current * 1.25;
    final minSize = _cableForCurrent(designCurrent);
    final recSize = _nextCableSize(minSize * 1.25);
    return {'min_size': '${_fmt(minSize)} mm²', 'rec_size': '${_fmt(recSize)} mm²'};
  }

  static Map<String, String> _motorFlc(Map<String, double> x) {
    final power = _positive(x, 'power');
    final voltage = _positive(x, 'voltage');
    final pf = _bounded(x, 'pf', min: 0.1, max: 1);
    final efficiency = _bounded(x, 'efficiency', min: 1, max: 100) / 100;
    final flc = (power * 1000) / (math.sqrt(3) * voltage * pf * efficiency);
    return {'flc': '${_fmt(flc)} A', 'dol_starter': '${_fmt(_nextBreaker(flc * 1.25))} A'};
  }

  static Map<String, String> _transformerSize(Map<String, double> x) {
    final load = _positive(x, 'load');
    final pf = _bounded(x, 'pf', min: 0.1, max: 1);
    final margin = _bounded(x, 'margin', min: 0, max: 100);
    final kva = load / pf;
    final withMargin = kva * (1 + margin / 100);
    return {'kva': '${_fmt(kva)} kVA', 'with_margin': '${_fmt(withMargin)} kVA'};
  }

  static Map<String, String> _solarArray(Map<String, double> x) {
    final dailyEnergy = _positive(x, 'daily_energy');
    final sunHours = _positive(x, 'sun_hours');
    final systemEff = _bounded(x, 'system_eff', min: 1, max: 100) / 100;
    final panelWatt = _positive(x, 'panel_watt');
    final arrayKw = dailyEnergy / (sunHours * systemEff);
    final panelCount = (arrayKw * 1000 / panelWatt).ceil();
    return {'array_kw': '${_fmt(arrayKw)} kWp', 'panel_count': '$panelCount panels'};
  }

  static Map<String, String> _breakerSize(Map<String, double> x) {
    final loadCurrent = _positive(x, 'load_current');
    final multiplier = _bounded(x, 'multiplier', min: 1, max: 3);
    final breaker = _nextBreaker(loadCurrent * multiplier);
    final cable = _cableForBreaker(breaker);
    return {'breaker': '${_fmt(breaker, digits: 0)} A', 'cable_size': '${_fmt(cable)} mm²'};
  }

  static Map<String, String> _conduitFill(Map<String, double> x) {
    final conduitDia = _positive(x, 'conduit_diameter');
    final cableDia = _positive(x, 'cable_diameter');
    final count = _positive(x, 'cable_count');
    final fill = (count * cableDia * cableDia) / (conduitDia * conduitDia) * 100;
    final maxCount40 = (0.40 * conduitDia * conduitDia / (cableDia * cableDia)).floor();
    return {
      'fill_percent': '${_fmt(fill)} %',
      'max_cables_40': '$maxCount40 cables',
      'status': fill <= 40 ? 'OK for 40% fill guideline' : 'Over 40% fill — use larger conduit',
    };
  }

  static Map<String, String> _ledSavings(Map<String, double> x) {
    final oldW = _positive(x, 'old_watts');
    final newW = _positive(x, 'new_watts');
    final qty = _positive(x, 'quantity');
    final hours = _positive(x, 'hours_per_day');
    final tariff = _positive(x, 'tariff');
    if (newW >= oldW) throw const CalculationException('New LED wattage must be lower than old lamp wattage.');
    final dailyKwh = (oldW - newW) * qty * hours / 1000;
    final monthlyKwh = dailyKwh * 30;
    final monthlySaving = monthlyKwh * tariff;
    return {
      'daily_kwh_saved': '${_fmt(dailyKwh)} kWh/day',
      'monthly_kwh_saved': '${_fmt(monthlyKwh)} kWh/month',
      'monthly_cost_saved': 'Rs. ${_fmt(monthlySaving)} /month',
    };
  }

  static Map<String, String> _batteryBank(Map<String, double> x) {
    final energyKwh = _positive(x, 'energy_kwh');
    final systemVoltage = _positive(x, 'system_voltage');
    final batteryAh = _positive(x, 'battery_ah');
    final dod = _bounded(x, 'dod', min: 1, max: 100) / 100;
    final efficiency = _bounded(x, 'efficiency', min: 1, max: 100) / 100;
    final requiredAh = (energyKwh * 1000) / (systemVoltage * dod * efficiency);
    final batteries = (requiredAh / batteryAh).ceil();
    return {'required_ah': '${_fmt(requiredAh)} Ah', 'battery_count': '$batteries batteries in parallel-equivalent'};
  }

  static Map<String, String> _voltageDivider(Map<String, double> x) {
    final vin = _positive(x, 'vin');
    final r1 = _positive(x, 'r1');
    final r2 = _positive(x, 'r2');
    final vout = vin * r2 / (r1 + r2);
    final currentMa = vin / (r1 + r2) * 1000;
    return {'vout': '${_fmt(vout)} V', 'divider_current': '${_fmt(currentMa)} mA'};
  }

  static Map<String, String> _groundResistance(Map<String, double> x) {
    final rho = _positive(x, 'soil_resistivity');
    final length = _positive(x, 'rod_length');
    final diameterMm = _positive(x, 'rod_diameter');
    final diameterM = diameterMm / 1000;
    if (diameterM >= length) throw const CalculationException('Rod diameter must be much smaller than rod length.');
    final resistance = (rho / (2 * math.pi * length)) * (math.log((4 * length) / diameterM) - 1);
    return {'earth_resistance': '${_fmt(resistance)} Ω', 'note': resistance <= 5 ? 'Good target for many installations' : 'High — consider extra rods/soil treatment'};
  }

  static Map<String, String> _harmonicsThd(Map<String, double> x) {
    final fundamental = _positive(x, 'fundamental');
    final harmonicRms = _positive(x, 'harmonic_rms');
    final thd = harmonicRms / fundamental * 100;
    return {'thd_percent': '${_fmt(thd)} %', 'quality_note': thd <= 5 ? 'Low distortion' : thd <= 20 ? 'Moderate distortion' : 'High distortion — investigate'};
  }

  static Map<String, String> _powerFactorCorrection(Map<String, double> x) {
    final kw = _positive(x, 'kw');
    final currentPf = _bounded(x, 'current_pf', min: 0.1, max: 0.99);
    final targetPf = _bounded(x, 'target_pf', min: 0.1, max: 1);
    if (targetPf <= currentPf) throw const CalculationException('Target PF must be higher than current PF.');
    final kvar = kw * (math.tan(math.acos(currentPf)) - math.tan(math.acos(targetPf)));
    return {'kvar_required': '${_fmt(kvar)} kVAr', 'corrected_kva': '${_fmt(kw / targetPf)} kVA'};
  }

  static Map<String, String> _kwToHp(Map<String, double> x) {
    final kw = _positive(x, 'kw');
    return {'hp': '${_fmt(kw / 0.746)} HP'};
  }

  static Map<String, String> _hpToKw(Map<String, double> x) {
    final hp = _positive(x, 'hp');
    return {'kw': '${_fmt(hp * 0.746)} kW'};
  }

  static Map<String, String> _singlePhaseCurrent(Map<String, double> x) {
    final kw = _positive(x, 'kw');
    final voltage = _positive(x, 'voltage');
    final pf = _bounded(x, 'pf', min: 0.1, max: 1);
    final current = kw * 1000 / (voltage * pf);
    return {'current': '${_fmt(current)} A'};
  }

  static Map<String, String> _threePhaseCurrent(Map<String, double> x) {
    final kw = _positive(x, 'kw');
    final voltage = _positive(x, 'voltage');
    final pf = _bounded(x, 'pf', min: 0.1, max: 1);
    final efficiency = _bounded(x, 'efficiency', min: 1, max: 100) / 100;
    final current = kw * 1000 / (math.sqrt(3) * voltage * pf * efficiency);
    return {'current': '${_fmt(current)} A'};
  }

  static Map<String, String> _cableResistance(Map<String, double> x) {
    final resistivity = _positive(x, 'resistivity');
    final length = _positive(x, 'length');
    final area = _positive(x, 'area');
    final resistance = resistivity * length / area;
    return {'resistance': '${_fmt(resistance)} Ω', 'loop_resistance': '${_fmt(resistance * 2)} Ω loop'};
  }

  static Map<String, String> _shortCircuitCurrent(Map<String, double> x) {
    final voltage = _positive(x, 'voltage');
    final impedance = _positive(x, 'impedance');
    final current = voltage / impedance;
    return {'fault_current': '${_fmt(current)} A', 'fault_current_ka': '${_fmt(current / 1000)} kA'};
  }

  static Map<String, String> _upsBackupTime(Map<String, double> x) {
    final batteryVoltage = _positive(x, 'battery_voltage');
    final batteryAh = _positive(x, 'battery_ah');
    final batteryCount = _positive(x, 'battery_count');
    final loadW = _positive(x, 'load_watts');
    final efficiency = _bounded(x, 'efficiency', min: 1, max: 100) / 100;
    final hours = batteryVoltage * batteryAh * batteryCount * efficiency / loadW;
    return {'backup_hours': '${_fmt(hours)} hours', 'backup_minutes': '${_fmt(hours * 60, digits: 0)} minutes'};
  }

  static Map<String, String> _capacitorBankSize(Map<String, double> x) {
    final kw = _positive(x, 'kw');
    final currentPf = _bounded(x, 'current_pf', min: 0.1, max: 0.99);
    final targetPf = _bounded(x, 'target_pf', min: 0.1, max: 1);
    final voltage = _positive(x, 'voltage');
    final frequency = _positive(x, 'frequency');
    if (targetPf <= currentPf) throw const CalculationException('Target PF must be higher than current PF.');
    final kvar = kw * (math.tan(math.acos(currentPf)) - math.tan(math.acos(targetPf)));
    final capacitanceF = (kvar * 1000) / (3 * 2 * math.pi * frequency * voltage * voltage);
    return {'kvar_required': '${_fmt(kvar)} kVAr', 'capacitance_per_phase': '${_fmt(capacitanceF * 1000000)} µF/phase'};
  }

  static Map<String, String> _earthingConductorSize(Map<String, double> x) {
    final faultCurrent = _positive(x, 'fault_current');
    final time = _positive(x, 'disconnection_time');
    final k = _positive(x, 'k_factor');
    final minPractical = _positive(x, 'min_practical');
    final size = faultCurrent * math.sqrt(time) / k;
    final selected = math.max(_nextCableSize(size), minPractical);
    return {'adiabatic_size': '${_fmt(size)} mm²', 'selected_size': '${_fmt(selected)} mm²'};
  }


  static Map<String, String> _energyKwh(Map<String, double> x) {
    final energy = _positive(x, 'power_kw') * _positive(x, 'hours');
    return {'energy': '${_fmt(energy)} kWh'};
  }

  static Map<String, String> _jouleHeating(Map<String, double> x) {
    final heat = math.pow(_positive(x, 'current'), 2) * _positive(x, 'resistance') * _positive(x, 'time');
    return {'heat': '${_fmt(heat.toDouble())} J'};
  }

  static Map<String, String> _kvaToKw(Map<String, double> x) {
    final pf = _bounded(x, 'pf', min: 0.1, max: 1);
    return {'kw': '${_fmt(_positive(x, 'kva') * pf)} kW'};
  }

  static Map<String, String> _kwToKva(Map<String, double> x) {
    final pf = _bounded(x, 'pf', min: 0.1, max: 1);
    return {'kva': '${_fmt(_positive(x, 'kw') / pf)} kVA'};
  }

  static Map<String, String> _demandFactor(Map<String, double> x) {
    final df = _positive(x, 'max_demand') / _positive(x, 'connected_load') * 100;
    return {'demand_factor': '${_fmt(df)} %'};
  }

  static Map<String, String> _loadBalancing(Map<String, double> x) {
    final l1 = x['l1'] ?? 0;
    final l2 = x['l2'] ?? 0;
    final l3 = x['l3'] ?? 0;
    final avg = (l1 + l2 + l3) / 3;
    if (avg <= 0) throw const CalculationException('At least one phase current must be greater than zero.');
    final maxDev = [l1, l2, l3].map((v) => (v - avg).abs()).reduce((a, b) => a > b ? a : b);
    return {'average': '${_fmt(avg)} A', 'imbalance': '${_fmt(maxDev / avg * 100)} %'};
  }

  static Map<String, String> _inverterSize(Map<String, double> x) {
    return {'inverter_kw': '${_fmt(_positive(x, 'load_kw') * _positive(x, 'surge_factor'))} kW'};
  }

  static Map<String, String> _evChargerLoad(Map<String, double> x) {
    final kw = _positive(x, 'charger_kw');
    final current = kw * 1000 / _positive(x, 'voltage');
    return {'current': '${_fmt(current)} A', 'daily_energy': '${_fmt(kw * _positive(x, 'hours'))} kWh'};
  }

  static Map<String, String> _mpptEstimator(Map<String, double> x) {
    final v = _positive(x, 'panel_vmp') * _positive(x, 'series_count');
    final i = _positive(x, 'panel_imp') * _positive(x, 'parallel_count');
    return {'string_voltage': '${_fmt(v)} V', 'array_current': '${_fmt(i)} A', 'array_power': '${_fmt(v * i)} W'};
  }

  static Map<String, String> _luxLevel(Map<String, double> x) {
    final uf = _bounded(x, 'uf', min: 0.1, max: 1);
    return {'lux': '${_fmt(_positive(x, 'lumens') * uf / _positive(x, 'area'))} lux'};
  }

  static Map<String, String> _roomLumenMethod(Map<String, double> x) {
    final uf = _bounded(x, 'uf', min: 0.1, max: 1);
    final mf = _bounded(x, 'mf', min: 0.1, max: 1);
    return {'required_lumens': '${_fmt(_positive(x, 'target_lux') * _positive(x, 'area') / (uf * mf))} lm'};
  }

  static Map<String, String> _cablePowerLoss(Map<String, double> x) {
    final loss = math.pow(_positive(x, 'current'), 2) * _positive(x, 'loop_resistance');
    return {'loss_watts': '${_fmt(loss.toDouble())} W'};
  }

  static Map<String, String> _fuseSize(Map<String, double> x) {
    return {'fuse': '${_fmt(_nextBreaker(_positive(x, 'load_current') * _positive(x, 'multiplier')), digits: 0)} A'};
  }

  static Map<String, String> _rcdLeakageCheck(Map<String, double> x) {
    final pct = (x['leakage_ma'] ?? 0) / _positive(x, 'rcd_ma') * 100;
    return {'leakage_percent': '${_fmt(pct)} %', 'status': pct < 30 ? 'Low leakage' : pct < 70 ? 'Investigate leakage' : 'High leakage / trip risk'};
  }

  static Map<String, String> _cableTrayFill(Map<String, double> x) {
    final fill = _positive(x, 'cable_area') / (_positive(x, 'tray_width') * _positive(x, 'tray_depth')) * 100;
    return {'fill_percent': '${_fmt(fill)} %'};
  }

  static Map<String, String> _earthElectrodeParallel(Map<String, double> x) {
    final util = _bounded(x, 'utilization', min: 0.1, max: 1);
    return {'combined_resistance': '${_fmt(_positive(x, 'single_rod') / (_positive(x, 'rod_count') * util))} Ω'};
  }

  static Map<String, String> _awgToMm2(Map<String, double> x) {
    final awg = x['awg'] ?? 0;
    final area = 0.012668 * math.pow(92, (36 - awg) / 19.5);
    return {'area': '${_fmt(area.toDouble())} mm²'};
  }

  static Map<String, String> _mm2ToAwg(Map<String, double> x) {
    final area = _positive(x, 'area');
    final awg = 36 - 19.5 * (math.log(area / 0.012668) / math.log(92));
    return {'awg': '${_fmt(awg, digits: 1)} AWG'};
  }

  static Map<String, String> _resistorColorNumeric(Map<String, double> x) {
    final d1 = (x['digit1'] ?? 0).round().clamp(0, 9);
    final d2 = (x['digit2'] ?? 0).round().clamp(0, 9);
    final mult = (x['multiplier'] ?? 0).round().clamp(0, 9);
    final r = (10 * d1 + d2) * math.pow(10, mult);
    return {'resistance': '${_fmt(r.toDouble())} Ω', 'tolerance_out': '±${_fmt(x['tolerance'] ?? 0)} %'};
  }

  static Map<String, String> _capacitorCode(Map<String, double> x) {
    final code = _positive(x, 'code').round().toString().padLeft(3, '0');
    final base = int.parse(code.substring(0, 2));
    final exp = int.parse(code.substring(2, 3));
    final pf = base * math.pow(10, exp).toDouble();
    return {'cap_pf': '${_fmt(pf)} pF', 'cap_nf': '${_fmt(pf / 1000)} nF', 'cap_uf': '${_fmt(pf / 1000000)} µF'};
  }

  static Map<String, String> _transformerCurrent(Map<String, double> x) {
    final kva = _positive(x, 'kva');
    final v = _positive(x, 'voltage');
    final phase = (x['phase'] ?? 3).round();
    final current = phase == 1 ? kva * 1000 / v : kva * 1000 / (math.sqrt(3) * v);
    return {'current': '${_fmt(current)} A'};
  }

  static Map<String, String> _generatorSize(Map<String, double> x) {
    final kva = _positive(x, 'load_kw') / _bounded(x, 'pf', min: 0.1, max: 1) * (1 + (x['margin'] ?? 0) / 100);
    return {'generator_kva': '${_fmt(kva)} kVA'};
  }

  static Map<String, String> _ctRatio(Map<String, double> x) {
    final sec = _positive(x, 'primary_current') * _positive(x, 'ct_secondary') / _positive(x, 'ct_primary');
    return {'secondary_current': '${_fmt(sec)} A'};
  }

  static Map<String, String> _frequencyPeriod(Map<String, double> x) {
    return {'period_ms': '${_fmt(1000 / _positive(x, 'frequency'))} ms'};
  }

  static Map<String, String> _temperatureCorrection(Map<String, double> x) {
    return {'corrected_ampacity': '${_fmt(_positive(x, 'base_ampacity') * _positive(x, 'correction_factor'))} A'};
  }

  static Map<String, String> _batteryRuntimeDc(Map<String, double> x) {
    final runtime = _positive(x, 'voltage') * _positive(x, 'ah') * _bounded(x, 'dod', min: 1, max: 100) / 100 * _bounded(x, 'efficiency', min: 1, max: 100) / 100 / _positive(x, 'load_w');
    return {'runtime': '${_fmt(runtime)} hours'};
  }

  static bool _hasPositive(Map<String, double> inputs, String key) => (inputs[key] ?? 0) > 0;

  static double _positive(Map<String, double> inputs, String key) {
    final value = inputs[key];
    if (value == null || value <= 0) throw CalculationException('Enter a value greater than zero for $key.');
    return value;
  }

  static double _bounded(Map<String, double> inputs, String key, {required double min, required double max}) {
    final value = _positive(inputs, key);
    if (value < min || value > max) throw CalculationException('$key must be between $min and $max.');
    return value;
  }

  static double _nextBreaker(double current) {
    return _standardBreakers.firstWhere((rating) => rating >= current, orElse: () => _standardBreakers.last);
  }

  static double _nextCableSize(double size) {
    return _standardCableSizes.firstWhere((rating) => rating >= size, orElse: () => _standardCableSizes.last);
  }

  static double _cableForCurrent(double current) {
    if (current <= 15) return 1.5;
    if (current <= 20) return 2.5;
    if (current <= 27) return 4;
    if (current <= 36) return 6;
    if (current <= 47) return 10;
    if (current <= 63) return 16;
    if (current <= 85) return 25;
    if (current <= 110) return 35;
    if (current <= 135) return 50;
    if (current <= 170) return 70;
    if (current <= 210) return 95;
    if (current <= 250) return 120;
    return 150;
  }

  static double _cableForBreaker(double breaker) {
    if (breaker <= 10) return 1.5;
    if (breaker <= 20) return 2.5;
    if (breaker <= 25) return 4;
    if (breaker <= 32) return 6;
    if (breaker <= 50) return 10;
    if (breaker <= 63) return 16;
    if (breaker <= 100) return 25;
    if (breaker <= 125) return 35;
    if (breaker <= 160) return 50;
    if (breaker <= 200) return 70;
    if (breaker <= 250) return 95;
    return 120;
  }

  static String _fmt(double value, {int digits = 2}) {
    if (!value.isFinite) throw const CalculationException('Result is not finite. Check input values.');
    var fixed = value.toStringAsFixed(digits);
    if (fixed.contains('.')) {
      while (fixed.endsWith('0')) {
        fixed = fixed.substring(0, fixed.length - 1);
      }
      if (fixed.endsWith('.')) fixed = fixed.substring(0, fixed.length - 1);
    }
    return fixed;
  }
}
