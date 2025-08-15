import 'dart:io';

class Student {
  String name;
  double toan;
  double ly;
  double hoa;

  Student(this.name, this.toan, this.ly, this.hoa);

  double tb() => (toan + ly + hoa) / 3;

  void hl(double tb) {
    if (tb < 5) {
      print('Học lực kém.');
    } else if (tb >= 5 && tb < 7) {
      print('Học lực khá.');
    } else if (tb >= 7 && tb <= 9) {
      print('Học lực giỏi');
    } else {
      print('Học lực xuất sắc.');
    }
  }
}

Student findMaxGrade(List<Student> students) =>
    students.reduce((a, b) => a.tb() > b.tb() ? a : b);
double nhapDiem(String mon) {
  while (true) {
    print('Nhập điểm $mon (0 - 10):');
    String? input = stdin.readLineSync();
    double? diem = double.tryParse(input ?? '');
    if (diem != null && diem >= 0 && diem <= 10) {
      return diem;
    }
    print("Điểm không hợp lệ! Mời nhập lại:");
  }
}
void main() {
  List<Student> students = [];
  while (true) {
    print('\nChọn:');
    print('1. Thêm sinh viên');
    print('2. Hiển thị danh sách');
    print('3. Tìm sinh viên có điểm TB cao nhất');
    print('0. Thoát chương trình');

    int? k = int.tryParse(stdin.readLineSync() ?? '');
    if (k == null) {
      print('Vui lòng nhập số hợp lệ.');
      continue;
    }

    if (k == 0) {
      print('Thoát chương trình.');
      break;
    }

    switch (k) {
      case 1:
        print('Nhập họ và tên:');
        String ten = stdin.readLineSync()!;
        double dtoan = nhapDiem("Toán");
        double dly = nhapDiem("Lý");
        double dhoa = nhapDiem("Hóa");

        students.add(Student(ten, dtoan, dly, dhoa));
        break;

      case 2:
        if (students.isEmpty) {
          print('Danh sách rỗng!');
        } else {
          students.forEach((sv) {
            print('Sinh viên: ${sv.name} - Điểm TB: ${sv.tb()}');
            sv.hl(sv.tb());
            print('-----------------');
          });
        }
        break;

      case 3:
        if (students.isEmpty) {
          print('Danh sách rỗng!');
        } else {
          var maxSv = findMaxGrade(students);
          print('Sinh viên có điểm TB cao nhất: ${maxSv.name} (${maxSv.tb()})');
        }
        break;

      default:
        print('Lựa chọn không hợp lệ.');
    }
  }
}
