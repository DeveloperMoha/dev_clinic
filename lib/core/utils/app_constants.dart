import 'package:mysql1/mysql1.dart';

class AppConstants {
  // var settings = ConnectionSettings(
  //   host: connectionHost,
  //   port: connectionPort,
  //   user: connectionUser,
  //   password: connectionPass,
  //   db: connectionDbName,
  // );

  static const String connectionHost = "sql.freedb.tech";
  static const int connectionPort = 3306;
  static const String connectionUser = "freedb_devmoha";
  static const String connectionPass = "5hE#U2c#%*NPkfy";
  static const String connectionDbName = "freedb_clinic_db";
  //==============================================================
  // static const String connectionHost = "192.168.1.3";
  // static const int connectionPort = 3306;
  // static const String connectionUser = "root";
  // static const String connectionPass = "";
  // static const String connectionDbName = "clinic_db";
//to connect to local host from emulator use
/*
to connect to local host from emulator use 
  static const String connectionHost = "192.168.1.3";
  static const int connectionPort = 3306;
  static const String connectionUser = "root";
  don't use pass in connection parameters
  static const String connectionDbName = "clinic_db";
*/

//to connect to online server from emulator or real device
/*
  static const String connectionHost = "sql.freedb.tech";
  static const int connectionPort = 3306;
  static const String connectionUser = "freedb_devmoha";
  static const String connectionPass = "5hE#U2c#%*NPkfy";
  static const String connectionDbName = "freedb_clinic_db";
*/

  static const String getAllReservationQuery =
      "SELECT reservations.*,patients.name FROM `reservations`,patients WHERE reservations.patient_id = patients.patient_id AND reservations.date =";

  static const String getAllPatientQuery =
      "SELECT `patient_id`, `name`, `age`, `address`, `phone`, `education`, `social_statue` FROM `patients`";

  static const String addNewPatientQuery =
      "INSERT INTO `patients`(`name`, `age`, `address`, `phone`, `education`, `social_statue`) VALUES (?,?,?,?,?,?)";

  static const String addNewReservationQuery =
      "INSERT INTO `reservations`(`patient_id`, `type`, `date`, `time`, `price`, `paid`, `rest`, `current_specification`, `given_medicine`, `notes`, `reservation_case`) VALUES (?,?,?,?,?,?,?,?,?,?,?)";

  static const String getAllDoctorsQuery =
      "SELECT `doctor_id`, `name`, `age`, `phone`, `specification` FROM `doctors`  ";

  static const String addNewDoctorQuery =
      "INSERT INTO `doctors`(`name`, `age`, `phone`, `specification`) VALUES (?,?,?,?)";

  static const String updateDoctorQuery =
      "UPDATE `doctors` SET `name`= ?,`age`= ?,`phone`= ?,`specification`= ? WHERE `doctor_id`= ?";

  static const String getPatientByQuery =
      "SELECT * FROM `patients` ORDER BY ? ";

  static String getPatientByOrderedQuery(String order) {
    return "SELECT * FROM `patients` ORDER BY $order ASC";
  }
}
