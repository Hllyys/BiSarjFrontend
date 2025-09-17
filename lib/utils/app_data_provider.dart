import 'package:frontend_bisarj/model/booking_model.dart';
import 'package:frontend_bisarj/model/charging_station_model.dart';
import 'package:frontend_bisarj/model/geo_point_model.dart';
import 'package:frontend_bisarj/model/vehicle_list_model.dart';
import 'package:frontend_bisarj/model/wallet_model.dart';

import '../model/charger_model.dart';
import '../model/vehicle_model.dart';
import '../model/payment_model.dart';
import 'app_assets.dart';

List<PaymentModel> paymentList() {
  List<PaymentModel> list = [];
  list.add(PaymentModel(title: 'Stripe', image: ic_stripe));
  list.add(PaymentModel(title: 'PayPal', image: ic_paypal));
  return list;
}

List<PaymentModel> carList() {
  List<PaymentModel> list = [];
  list.add(
    PaymentModel(
      title: 'Tesla',
      subTitle: 'Model S . 40',
      image: ic_icon_tesla,
    ),
  );
  list.add(
    PaymentModel(
      title: 'Audi',
      subTitle: 'e-Tron . Prestige',
      image: ic_audi_icon,
    ),
  );
  list.add(
    PaymentModel(
      title: 'Porsche',
      subTitle: 'TayCan . Turbo S',
      image: ic_car_3,
    ),
  );
  list.add(
    PaymentModel(
      title: 'Ford',
      subTitle: 'Mustang Mach-E . GT',
      image: ic_car_4,
    ),
  );
  list.add(
    PaymentModel(
      title: 'Volkswagen',
      subTitle: 'ID.4 . 1st Edition',
      image: ic_volkswagen,
    ),
  );
  list.add(
    PaymentModel(title: 'Kia', subTitle: 'Niro Ev . EX Premium', image: ic_kia),
  );
  list.add(
    PaymentModel(
      title: 'hyundai',
      subTitle: 'Mustang Mach-E . GT',
      image: ic_hyundai,
    ),
  );

  return list;
}

List<PaymentModel> chargerList() {
  List<PaymentModel> list = [];
  list.add(
    PaymentModel(title: 'Tesla . AC/DC', subTitle: '100', image: ic_ev_1),
  );
  list.add(PaymentModel(title: 'CCS1 . DC', subTitle: '50', image: ic_ev_2));
  list.add(PaymentModel(title: 'CCS1 . DC', subTitle: '100', image: ic_ev_3));
  list.add(
    PaymentModel(title: 'CHAdeMo . DC  ', subTitle: '50', image: ic_ev_4),
  );
  list.add(
    PaymentModel(title: 'Mennekes . DC', subTitle: '100', image: ic_ev_1),
  );
  list.add(PaymentModel(title: 'J1772 . AC', subTitle: '50', image: ic_ev_2));
  list.add(PaymentModel(title: 'Tesla . DC', subTitle: '100', image: ic_ev_3));

  return list;
}

List<WalletModel> WalletList() {
  List<WalletModel> list = [];
  list.add(
    WalletModel(status: 1, createDate: 'Dec 17, 2024 : 12:44 PM', amount: 100),
  );
  list.add(
    WalletModel(status: 1, createDate: 'Dec 17, 2024 : 12:44 PM', amount: 100),
  );
  list.add(
    WalletModel(status: 1, createDate: 'Dec 17, 2024 : 12:44 PM', amount: 100),
  );
  list.add(
    WalletModel(status: 1, createDate: 'Dec 17, 2024 : 12:44 PM', amount: 100),
  );
  list.add(
    WalletModel(status: 1, createDate: 'Dec 17, 2024 : 12:44 PM', amount: 100),
  );
  list.add(
    WalletModel(status: 1, createDate: 'Dec 17, 2024 : 12:44 PM', amount: 100),
  );
  list.add(
    WalletModel(status: 1, createDate: 'Dec 17, 2024 : 12:44 PM', amount: 100),
  );

  return list;
}

List<PaymentModel> paymentMethod() {
  List<PaymentModel> list = [];
  list.add(
    PaymentModel(title: 'E-Wallet', subTitle: '\$978.50', image: ic_wallet),
  );
  list.add(PaymentModel(title: 'PayPal', image: ic_paypal));
  list.add(PaymentModel(title: 'Stripe', image: ic_stripe));
  list.add(PaymentModel(title: 'RazorPay', image: ic_razorPay));
  list.add(PaymentModel(title: 'PayFast', image: ic_PayFast));

  return list;
}

List<PaymentModel> CheckInData() {
  List<PaymentModel> list = [];
  list.add(PaymentModel(title: 'Charging Now', image: ic_battery));
  list.add(PaymentModel(title: 'Waiting', image: ic_time));
  list.add(PaymentModel(title: 'Successfully Charged', image: ic_message));
  list.add(PaymentModel(title: 'Could Not Charge', image: ic_speech_bubble));
  list.add(PaymentModel(title: 'Leave a Comment', image: ic_messenger));

  return list;
}

List<PaymentModel> CancelList() {
  List<PaymentModel> list = [];
  list.add(PaymentModel(title: 'I encountered an unexpected circumstance'));
  list.add(PaymentModel(title: 'I had a schedule change'));
  list.add(PaymentModel(title: 'I found an alternative charging option'));
  list.add(PaymentModel(title: 'Inconvenient location'));
  list.add(PaymentModel(title: 'I\'m having a technical problem'));
  list.add(PaymentModel(title: 'High charging cost'));
  list.add(PaymentModel(title: 'Weather conditions'));
  list.add(PaymentModel(title: 'Lack of amenities'));
  list.add(PaymentModel(title: 'Unavailability of charging spot'));
  list.add(PaymentModel(title: 'Parking availability'));
  list.add(PaymentModel(title: 'Others'));

  return list;
}

List<VehicleListModel> addVehicle() {
  List<VehicleListModel> list = [];
  list.add(
    VehicleListModel(
      name: 'All',
      vehicleModel: [
        VehicleModel(
          companyId: 'SkZNYEmGMdGh4aCbJBTr',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '84',
          name: 'BMW i4',
          image: ic_bmw,
        ),
        VehicleModel(
          companyId: 'SkZNYEmGMdGh4aCbJBTr',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '71',
          name: 'iX xDrive40',
          image: ic_bmw,
        ),
        VehicleModel(
          companyId: '3QrtTNIfoKgB7zRpcgtS',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '45',
          name: 'MG ZS EV',
          image: ic_mg_1,
        ),
        VehicleModel(
          companyId: '3QrtTNIfoKgB7zRpcgtS',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '51',
          name: 'MG ZS EV 2024',
          image: ic_mg_2,
        ),
        VehicleModel(
          companyId: '3QrtTNIfoKgB7zRpcgtS',
          chargerType: ['Wall', 'Type-2'],
          batteryCapacity: '51',
          name: 'MG Comet',
          image: ic_mg_3,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '31',
          name: 'Tata Nexon EV',
          image: ic_tata_1,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2', 'GBT'],
          batteryCapacity: '22',
          name: 'Tata Xpress-T\nEV',
          image: ic_tata_2,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '26',
          name: 'Tata Tigor\nZiptron EV',
          image: ic_tata_3,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '30',
          name: 'Tata Nexon EV\nMAx',
          image: ic_tata_4,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '20',
          name: 'Tata Tiago EV',
          image: ic_tata_1,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '24',
          name: 'Tata Tiago EV\nLR',
          image: ic_tata_2,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '30',
          name: 'Nexon EV 2023\nMR',
          image: ic_tata_3,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '41',
          name: 'Nexon EV 2023\nLR',
          image: ic_tata_4,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['Wall', 'GBT'],
          batteryCapacity: '22',
          name: 'TATA ACE EV',
          image: ic_tata_1,
        ),
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['Wall'],
          batteryCapacity: '11',
          name: 'Mahindra\ne2oPlus',
          image: ic_mahindra_1,
        ),
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['GBT', 'Wall', 'Type-2'],
          batteryCapacity: '22',
          name: 'Mahindra\ne-Verito',
          image: ic_mahindra_2,
        ),
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '35',
          name: 'Mahindra\nXUV400 EC',
          image: ic_mahindra_3,
        ),
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '40',
          name: 'Mahindra\nXUV400 EL',
          image: ic_mahindra_4,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Tata',
      vehicleModel: [
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '31',
          name: 'Tata Nexon EV',
          image: ic_tata_1,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2', 'GBT'],
          batteryCapacity: '22',
          name: 'Tata Xpress-T\nEV',
          image: ic_tata_2,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '26',
          name: 'Tata Tigor\nZiptron EV',
          image: ic_tata_3,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '30',
          name: 'Tata Nexon EV\nMAx',
          image: ic_tata_4,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '20',
          name: 'Tata Tiago EV',
          image: ic_tata_1,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '24',
          name: 'Tata Tiago EV\nLR',
          image: ic_tata_2,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '30',
          name: 'Nexon EV 2023\nMR',
          image: ic_tata_3,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '41',
          name: 'Nexon EV 2023\nLR',
          image: ic_tata_4,
        ),
        VehicleModel(
          companyId: 'ilggFRX9WKh9e1f9dWBc',
          chargerType: ['Wall', 'GBT'],
          batteryCapacity: '22',
          name: 'TATA ACE EV',
          image: ic_tata_1,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'MG',
      vehicleModel: [
        VehicleModel(
          companyId: '3QrtTNIfoKgB7zRpcgtS',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '45',
          name: 'MG ZS EV',
          image: ic_mg_1,
        ),
        VehicleModel(
          companyId: '3QrtTNIfoKgB7zRpcgtS',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '51',
          name: 'MG ZS EV 2024',
          image: ic_mg_2,
        ),
        VehicleModel(
          companyId: '3QrtTNIfoKgB7zRpcgtS',
          chargerType: ['Wall', 'Type-2'],
          batteryCapacity: '51',
          name: 'MG Comet',
          image: ic_mg_3,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Hyundai',
      vehicleModel: [
        VehicleModel(
          companyId: 'oQQJ8Bf1JWyxCEy79zAq',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '40',
          name: 'Hyundai Kona\nElectric',
          image: ic_hyundai_1,
        ),
        VehicleModel(
          companyId: 'oQQJ8Bf1JWyxCEy79zAq',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '58',
          name: 'Hyundai IONIQ\5',
          image: ic_hyundai_2,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Mahindra',
      vehicleModel: [
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['Wall'],
          batteryCapacity: '11',
          name: 'Mahindra\ne2oPlus',
          image: ic_mahindra_1,
        ),
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['GBT', 'Wall', 'Type-2'],
          batteryCapacity: '22',
          name: 'Mahindra\ne-Verito',
          image: ic_mahindra_2,
        ),
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '35',
          name: 'Mahindra\nXUV400 EC',
          image: ic_mahindra_3,
        ),
        VehicleModel(
          companyId: 'UfnkPq4LY9XZg07KL3Qb',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '40',
          name: 'Mahindra\nXUV400 EL',
          image: ic_mahindra_4,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Mercedes',
      vehicleModel: [
        VehicleModel(
          companyId: '65NNHBRvw7JOeMO2L1qj',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '80',
          name: 'EQC',
          image: ic_mercedes_1,
        ),
        VehicleModel(
          companyId: '65NNHBRvw7JOeMO2L1qj',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '108',
          name: 'Mercedes EQS',
          image: ic_mercedes_2,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Tesla',
      vehicleModel: [
        VehicleModel(
          companyId: 'QdZhDJHAeRQF0A6Cti5M',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '75',
          name: 'Tesla Model Y',
          image: ic_tesla,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Audi',
      vehicleModel: [
        VehicleModel(
          companyId: 'DoK4vrXEPBXafUUNdOJF',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '75',
          name: 'Audi e-tron',
          image: ic_audi,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Volvo',
      vehicleModel: [
        VehicleModel(
          companyId: 'r37UiB7JUY5Dw8pbe1Cr',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '78',
          name: 'Volvo XC40\nRecharge',
          image: ic_volvo_1,
        ),
        VehicleModel(
          companyId: 'r37UiB7JUY5Dw8pbe1Cr',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '78',
          name: 'Volvo XC40',
          image: ic_volvo_2,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Kia',
      vehicleModel: [
        VehicleModel(
          companyId: 'S0XLPJ2RiLHxGi38yeiR',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '78',
          name: 'Kia EV6',
          image: ic_car_kia,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'BMW',
      vehicleModel: [
        VehicleModel(
          companyId: 'SkZNYEmGMdGh4aCbJBTr',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '84',
          name: 'BMW i4',
          image: ic_bmw,
        ),
        VehicleModel(
          companyId: 'SkZNYEmGMdGh4aCbJBTr',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '71',
          name: 'iX xDrive40',
          image: ic_bmw,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Jaguar',
      vehicleModel: [
        VehicleModel(
          companyId: 'Yl30PtrviwJqrcqutC1F',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '90',
          name: 'I-Pace',
          image: ic_jaguar,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'Mini Cooper',
      vehicleModel: [
        VehicleModel(
          companyId: 'ugrATAC5geS64YMkGh9C',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '33',
          name: 'Mini Cooper SE',
          image: ic_miniCooper,
        ),
      ],
    ),
  );
  list.add(
    VehicleListModel(
      name: 'BYD',
      vehicleModel: [
        VehicleModel(
          companyId: 'GvwPxU6PZ4x4jNXj4ZTP',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '72',
          name: 'BYD E6',
          image: ic_byd_1,
        ),
        VehicleModel(
          companyId: 'GvwPxU6PZ4x4jNXj4ZTP',
          chargerType: ['CCS-2', 'Wall', 'Type-2'],
          batteryCapacity: '61',
          name: 'BYD Atto 3',
          image: ic_byd_2,
        ),
      ],
    ),
  );
  return list;
}

List<ChargerModel> listChargerList() {
  List<ChargerModel> list = [];
  list.add(
    ChargerModel(
      chargerImage: ic_plug_1,
      chargerMaxPower: 21,
      chargerStatus: 'Available',
      chargerType: 'AC',
      totalHours: 24,
    ),
  );
  list.add(
    ChargerModel(
      chargerImage: ic_plug_2,
      chargerMaxPower: 10,
      chargerStatus: 'In Use',
      chargerType: 'DC',
      totalHours: 24,
    ),
  );
  list.add(
    ChargerModel(
      chargerImage: ic_plug_3,
      chargerMaxPower: 30,
      chargerStatus: 'Available',
      chargerType: 'DC',
      totalHours: 24,
    ),
  );
  list.add(
    ChargerModel(
      chargerImage: ic_plug_4,
      chargerMaxPower: 10,
      chargerStatus: 'In Use',
      chargerType: 'DC',
      totalHours: 24,
    ),
  );

  return list;
}

List<ChargingStationModel> chargingStationListData() {
  List<ChargingStationModel> list = [];
  list.add(
    ChargingStationModel(
      stationName: 'Walgreens - Brooklyn,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'Brooklyn, 589 Prospect Avenue',
      stationLocation: GeoPointModel(latitude: 23.0225, longitude: 72.5714),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Adams St, NY',
      status: 'Available',
      avgReviewCount: '4',
      totalReview: 120,
      stationImage: ic_Station_1,
      stationAddress: '85003, United States',
      stationLocation: GeoPointModel(latitude: 10.1632, longitude: 76.6413),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Scottsdale Camelback,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 15.2993, longitude: 74.1240),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Lodge -North Brooklyn,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 31.1471, longitude: 75.3412),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Walgreens - Brooklyn,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'Brooklyn, 589 Prospect Avenue',
      stationLocation: GeoPointModel(latitude: 33.2778, longitude: 75.3412),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Adams St, NY',
      status: 'In Use',
      avgReviewCount: '4',
      totalReview: 120,
      stationImage: ic_Station_1,
      stationAddress: '85003, United States',
      stationLocation: GeoPointModel(latitude: 28.7041, longitude: 77.1025),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Scottsdale Camelback,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
        ChargerModel(chargerImage: ic_ev_2),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Lodge -North Brooklyn,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 31.1471, longitude: 75.3412),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_4),
        ChargerModel(chargerImage: ic_ev_2),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'The Palace By Park Jewels,  IN',
      status: 'Available',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Ajmer-Jaipur Expy, Narsinghpura, Jaipur',
      stationLocation: GeoPointModel(latitude: 26.9124, longitude: 75.7873),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'Radisson Blu Palace,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'B-1, Ambamata Scheme - A Rd, opp. ',
      stationLocation: GeoPointModel(latitude: 24.5854, longitude: 73.7125),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_4),
        ChargerModel(chargerImage: ic_ev_2),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'H-2 Scheme No 54,Garden, IN',
      status: 'Available',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Andore, Madhya Pradesh, India ',
      stationLocation: GeoPointModel(latitude: 22.7196, longitude: 75.8577),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_2),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'Lodge -North Brooklyn,  NY',
      status: 'Available',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Mandla - Jabalpur Rd, Tilhari, Madhya Pradesh h',
      stationLocation: GeoPointModel(latitude: 22.9734, longitude: 78.6569),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'JW Marriott,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Senapati Bapat Rd, Laxmi Society, Model Colony',
      stationLocation: GeoPointModel(latitude: 18.5204, longitude: 73.8567),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_1),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'Radisson Blu Brooklyn,  NY',
      status: 'Available',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Chatrapati Nagar, Nagpur, Maharashtra, North',
      stationLocation: GeoPointModel(latitude: 21.1458, longitude: 79.0882),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_1),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'Lodge -North Brooklyn,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 10.1632, longitude: 76.6413),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'MAYFAIR Lagoon,  NY',
      status: 'Available',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: ' 8-B, Jayadev Vihar, Bhubaneswar, North',
      stationLocation: GeoPointModel(latitude: 20.2376, longitude: 84.2700),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_1),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'Boutique -North Brooklyn,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Avenue 4682, Kathmandu',
      stationLocation: GeoPointModel(latitude: 28.3949, longitude: 84.1240),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_4),
        ChargerModel(chargerImage: ic_ev_1),
      ],
    ),
  );
  list.add(
    ChargingStationModel(
      stationName: 'Lodge -North Brooklyn,  NY',
      status: 'Available',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 22.9868, longitude: 87.8550),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_1),
      ],
    ),
  );

  return list;
}

List<ChargingStationModel> favoriteStationListData() {
  List<ChargingStationModel> list = [];
  list.add(
    ChargingStationModel(
      stationName: 'Walgreens - Brooklyn,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'Brooklyn, 589 Prospect Avenue',
      stationLocation: GeoPointModel(latitude: 23.0225, longitude: 72.5714),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Adams St, NY',
      status: 'Available',
      avgReviewCount: '4',
      totalReview: 120,
      stationImage: ic_Station_1,
      stationAddress: '85003, United States',
      stationLocation: GeoPointModel(latitude: 10.1632, longitude: 76.6413),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Scottsdale Camelback,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 15.2993, longitude: 74.1240),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Lodge -North Brooklyn,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 36.197, longitude: 112.053),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Walgreens - Brooklyn,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'Brooklyn, 589 Prospect Avenue',
      stationLocation: GeoPointModel(latitude: 32.933157, longitude: -85.9360),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Adams St, NY',
      status: 'In Use',
      avgReviewCount: '4',
      totalReview: 120,
      stationImage: ic_Station_1,
      stationAddress: '85003, United States',
      stationLocation: GeoPointModel(latitude: 28.7041, longitude: 77.1025),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_3),
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Scottsdale Camelback,  NY',
      status: 'Available',
      avgReviewCount: '4.5',
      totalReview: 128,
      stationImage: ic_Station_1,
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_2),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  list.add(
    ChargingStationModel(
      stationName: 'Lodge -North Brooklyn,  NY',
      status: 'In Use',
      avgReviewCount: '5',
      totalReview: 150,
      stationImage: ic_Station_1,
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 31.1471, longitude: 75.3412),
      chargerModel: [
        ChargerModel(chargerImage: ic_ev_1),
        ChargerModel(chargerImage: ic_ev_4),
      ],
    ),
  );

  return list;
}

ChargingStationModel getChargingDetailData() {
  ChargingStationModel model = ChargingStationModel(
    stationName: 'Walgreens - Brooklyn,  NY',
    stationAddress: 'Brooklyn, 589 Prospect Avenue',
    stationLocation: GeoPointModel(latitude: 31.1471, longitude: 75.3412),
    amenities: [
      AmenitiesModel(image: ic_lounge, name: 'Lounge'),
      AmenitiesModel(image: ic_wifi, name: 'Wi-Fi'),
      AmenitiesModel(image: ic_television, name: 'SnapSip'),
      AmenitiesModel(image: ic_lounge, name: 'Restrooms'),
      AmenitiesModel(image: ic_lounge, name: 'Lounge'),
      AmenitiesModel(image: ic_medicine, name: 'Pharmacy'),
      AmenitiesModel(image: ic_tools, name: 'Maintenance'),
      AmenitiesModel(image: ic_store, name: 'Restaurant'),
      AmenitiesModel(image: ic_store, name: 'Shops'),
    ],
  );
  return model;
}

List<BookingModel> getUpComingList() {
  List<BookingModel> list = [];
  list.add(
    BookingModel(
      createDate: 'Dec 17, 2024',
      time: '10:00 AM',
      stationName: 'Scottsdale Camelback,  NY',
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 19, 2024',
      time: '09:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 31.1471, longitude: 75.3412),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_4,
        chargerMaxPower: 80,
        totalHours: 2,
      ),
      totalAmount: 40.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 05, 2024',
      time: '11:00 AM',
      stationName: 'Scottsdale Camelback,  NY',
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_2,
        chargerMaxPower: 40,
        totalHours: 2,
      ),
      totalAmount: 100.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Oct 17, 2024',
      time: '08:00 AM',
      stationName: 'Adams St, NY',
      stationAddress: '85003, United States',
      stationLocation: GeoPointModel(latitude: 28.7041, longitude: 77.1025),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_4,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 80.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 27, 2024',
      time: '02:00 PM',
      stationName: 'Walgreens - Brooklyn,  NY',
      stationAddress: 'Brooklyn, 589 Prospect Avenue',
      stationLocation: GeoPointModel(latitude: 32.933157, longitude: -85.9360),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 50.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 30, 2024',
      time: '11:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 36.197, longitude: 112.053),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_4,
        chargerMaxPower: 80,
        totalHours: 1,
      ),
      totalAmount: 90.0,
      isRemind: false,
    ),
  );
  list.add(
    BookingModel(
      createDate: 'Dec 17, 2024',
      time: '10:00 AM',
      stationName: 'Scottsdale Camelback,  NY',
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 28, 2024',
      time: '07:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 15.2993, longitude: 74.1240),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 90,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Oct 17, 2024',
      time: '10:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 36.197, longitude: 112.053),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_2,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 17, 2024',
      time: '10:00 AM',
      stationName: 'Scottsdale Camelback,  NY',
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 19, 2024',
      time: '09:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 31.1471, longitude: 75.3412),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_4,
        chargerMaxPower: 80,
        totalHours: 2,
      ),
      totalAmount: 40.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 05, 2024',
      time: '11:00 AM',
      stationName: 'Scottsdale Camelback,  NY',
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_2,
        chargerMaxPower: 40,
        totalHours: 2,
      ),
      totalAmount: 100.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Oct 17, 2024',
      time: '08:00 AM',
      stationName: 'Adams St, NY',
      stationAddress: '85003, United States',
      stationLocation: GeoPointModel(latitude: 28.7041, longitude: 77.1025),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_4,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 80.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 27, 2024',
      time: '02:00 PM',
      stationName: 'Walgreens - Brooklyn,  NY',
      stationAddress: 'Brooklyn, 589 Prospect Avenue',
      stationLocation: GeoPointModel(latitude: 32.933157, longitude: -85.9360),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 50.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 30, 2024',
      time: '11:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 36.197, longitude: 112.053),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_4,
        chargerMaxPower: 80,
        totalHours: 1,
      ),
      totalAmount: 90.0,
      isRemind: false,
    ),
  );
  list.add(
    BookingModel(
      createDate: 'Dec 17, 2024',
      time: '10:00 AM',
      stationName: 'Scottsdale Camelback,  NY',
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 28, 2024',
      time: '07:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 15.2993, longitude: 74.1240),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 90,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: false,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Oct 17, 2024',
      time: '10:00 AM',
      stationName: 'Lodge -North Brooklyn,  NY',
      stationAddress: 'Avenue AZ-67, North',
      stationLocation: GeoPointModel(latitude: 36.197, longitude: 112.053),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_2,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: true,
    ),
  );

  list.add(
    BookingModel(
      createDate: 'Dec 17, 2024',
      time: '10:00 AM',
      stationName: 'Scottsdale Camelback,  NY',
      stationAddress: 'AZ 85253, United States',
      stationLocation: GeoPointModel(latitude: 25.9644, longitude: 85.2722),
      chargerModel: ChargerModel(
        chargerImage: ic_ev_1,
        chargerMaxPower: 100,
        totalHours: 1,
      ),
      totalAmount: 30.0,
      isRemind: true,
    ),
  );

  return list;
}
