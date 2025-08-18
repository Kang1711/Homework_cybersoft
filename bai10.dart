import 'dart:io';

List<Person> nguoi = [];
//Vì đề bài không có yêu cầu chức năng tạo lớp mới nên mặc định trường học có 3 lớp học
Classroom c1 = Classroom('10A1'); // id = 1
Classroom c2 = Classroom('10A2'); // id = 2
Classroom c3 = Classroom('10A3'); // id = 3
List<Classroom> classrooms = [c1, c2, c3];

enum Gender { male, female, other }

enum Subject { toan, hoa, sinh }

void hienThiDanhSachNguoi(var nguoi) {
  if (nguoi.isEmpty) {
    print("Danh sách người đang rỗng.");
    return;
  }
  print("------ Danh sách người ------");
  for (var person in nguoi) {
    print(
      "ID: ${person.id}, Tên: ${person.name}, Tuổi: ${person.age}, Giới tính: ${person.gender.toString().split('.').last}.",
    );
  }
  print("-----------------------------");
}

void hienThiLopTheoId() {
  int idLop = nhapIdLop();
  var lop = classrooms[idLop - 1];
  print("\n------ Thông tin lớp ${lop.name} (ID: ${lop.id}) ------");
  if (lop.teacher != null) {
    var gv = lop.teacher!;
    print(
      "Giáo viên: ${gv.name}, Tuổi: ${gv.age}, Giới tính: ${gv.gender.toString().split('.').last}, "
      "Môn: ${gv.subject.toString().split('.').last}, Lương: ${gv.salary}",
    );
  } else {
    print("Giáo viên: Chưa có");
  }
  if (lop.students.isEmpty) {
    print("Không có học sinh trong lớp.");
  } else {
    print("Danh sách học sinh:");
    for (var hs in lop.students) {
      print(
        "- ${hs.name}, Tuổi: ${hs.age}, Giới tính: ${hs.gender.toString().split('.').last}, Lớp: ${hs.grade}, "
        "Điểm TB: ${diemtb(hs).toStringAsFixed(2)}, "
        "Điểm cụ thể [Toán: ${hs.score[Subject.toan]}, Hóa: ${hs.score[Subject.hoa]}, Sinh: ${hs.score[Subject.sinh]}]",
      );
    }
  }

  print("------------------------------------------------");
}

int nhapIdLop() {
  while (true) {
    stdout.write("Nhập ID lớp (1, 2 hoặc 3): ");
    String? input = stdin.readLineSync();
    int? idk = int.tryParse(input ?? "");

    if (idk == 1 || idk == 2 || idk == 3) {
      return idk!;
    } else {
      print("ID không hợp lệ! Chỉ được nhập 1, 2 hoặc 3.");
    }
  }
}

String nhapTen(String k) {
  String? ten;
  final regex = RegExp(r"^[a-zA-ZÀ-ỹ\s]+$"); // Chỉ cho phép chữ cái và khoảng trắng, bao gồm tiếng Việt

  do {
    stdout.write("Nhập tên $k: ");
    ten = stdin.readLineSync();

    if (ten == null || ten.trim().isEmpty) {
      print("Tên $k không được để trống. Vui lòng nhập lại.");
      continue;
    }

    if (!regex.hasMatch(ten.trim())) {
      print("Tên $k chỉ được chứa chữ cái và khoảng trắng. Vui lòng nhập lại.");
      continue;
    }

    break;
  } while (true);

  return ten.trim();
}

Subject nhapMonHoc() {
  while (true) {
    print("Nhập môn học giáo viên sẽ dạy (toan/hoa/sinh):");
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print("Môn học không được để trống!");
      continue;
    }

    switch (input.toLowerCase()) {
      case "toan":
        return Subject.toan;
      case "hoa":
        return Subject.hoa;
      case "sinh":
        return Subject.sinh;
      default:
        print("Môn học không hợp lệ! Vui lòng nhập lại.");
    }
  }
}

int nhapTuoi() {
  while (true) {
    stdout.write("Nhập tuổi: ");
    int? age = int.tryParse(stdin.readLineSync() ?? "");
    if (age != null && age > 0) return age;
    print("Tuổi không hợp lệ, vui lòng nhập lại.");
  }
}

Gender nhapGioiTinh() {
  while (true) {
    print("Chọn giới tính:");
    print("1. Nam");
    print("2. Nữ");
    print("3. Khác");

    stdout.write("Nhập lựa chọn (1-3): ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        return Gender.male;
      case "2":
        return Gender.female;
      case "3":
        return Gender.other;
      default:
        print("Lựa chọn không hợp lệ, vui lòng nhập lại.");
    }
  }
}

double nhapLuong() {
  while (true) {
    stdout.write("Nhập lương: ");
    double? salary = double.tryParse(stdin.readLineSync() ?? "");
    if (salary != null && salary >= 0) return salary;
    print("Lương không hợp lệ, vui lòng nhập lại.");
  }
}

Map<Subject, double> nhapDiem() {
  final Map<Subject, double> diemSo = {};

  for (var mon in Subject.values) {
    //.values trong enum là toan, hoa, sinh
    while (true) {
      stdout.write(
        "Nhập điểm môn ${mon.toString().split('.').last}: ",
      ); // .name trong enum tức chuyển dạng chuỗi
      final input = stdin.readLineSync();
      if (input == null) {
        print("Vui lòng nhập lại!");
        continue;
      }
      final value = double.tryParse(input);
      if (value != null && value >= 0 && value <= 10) {
        diemSo[mon] = value;
        break;
      } else {
        print("Điểm không hợp lệ, nhập lại (0 - 10)!");
      }
    }
  }
  return diemSo;
}

class Person {
  static int _nextId = 1;
  int id;
  String name;
  int age;
  Gender gender;
  Person(this.name, this.age, this.gender) : id = _nextId++ {
    nguoi.add(this);
  }
}

class Student extends Person {
  String grade;
  Map<Subject, double> score;

  Student(super.name, super.age, super.gender, this.grade, this.score);
}

class Teacher extends Person {
  Subject subject;
  double salary;

  Teacher(super.name, super.age, super.gender, this.subject, this.salary);
}

class Classroom {
  static int _nextId = 1;
  String name;
  int id;
  List<Student> students = [];
  Teacher? teacher;
  Classroom(this.name) : id = _nextId++;

  void addStudent(Student a) {
    students.add(a);
    print('Đã thêm học sinh ${a.name} vào lớp $name.');
  }

  void addTeacher(Teacher a) {
    teacher = a;
    print(
      'Đã thêm giáo viên ${a.name} dạy môn ${a.subject.toString().split('.').last} phụ trách lớp $name.',
    );
  }

  void hienthi() {
    print('------Thông tin lớp học-----');
    print('Lớp $name có id $id.');
    print("Giáo viên: ${teacher?.name ?? "Chưa có"}");
    if (students.isEmpty) {
      print('Không có học sinh nào trong lớp.');
    } else {
      print('---------Danh sách lớp học--------');
      for (var s in students) {
        print(s.name);
      }
    }
  }
}

double diemtb(Student a) {
  return (a.score[Subject.toan]! +
          a.score[Subject.hoa]! +
          a.score[Subject.sinh]!) /
      3;
}

void themTeacher(Classroom k) {
  if (k.teacher != null) {
    print(
      'Đã có giáo viên ${k.teacher!.name} chủ nhiệm lớp ${k.name}, id lớp là: ${k.id}',
    );
  } else {
    print('Thêm giáo viên vào lớp học ${k.name} có id: ${k.id}.');
    var ten = nhapTen('giáo viên');
    var subject = nhapMonHoc();
    var age = nhapTuoi();
    var gender = nhapGioiTinh();
    var salary = nhapLuong();
    Teacher giaovien = Teacher(ten, age, gender, subject, salary);
    k.addTeacher(giaovien);
    print('Đã thêm giáo viên vào list.');
  }
}

void themStudent(Classroom k) {
  var ten = nhapTen('học sinh');
  var tuoi = nhapTuoi();
  var gioitinh = nhapGioiTinh();
  var cotdiem = nhapDiem();
  Student a = Student(ten, tuoi, gioitinh, k.name, cotdiem);
  k.addStudent(a);
}

void quanlyList() {
  print("\n----- Quản lý danh sách -----");
  print("1. Thêm");
  print("2. Sửa");
  print("3. Xoá");
  print("4. Hiển thị danh sách.");
  stdout.write("Chọn chức năng (1-4): ");
  String? choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      print('Chọn 1) Thêm học sinh vào danh sách.');
      print('Chọn 2) Thêm giáo viên vào danh sach.');
      int? p;
      while (true) {
        String? input = stdin.readLineSync();
        int? so = int.tryParse(input ?? '');
        if (so == null || (so != 1 && so != 2)) {
          print('Vui lòng nhập lại!');
          continue;
        }
        p = so;
        break;
      }
      var idlophoc = nhapIdLop();
      if (p == 1) {
        var loph = classrooms[idlophoc - 1];
        themStudent(loph);
        print('Đã thêm học sinh vào list.');
      } else if (p == 2) {
        themTeacher(classrooms[idlophoc - 1]);
      }
      break;

    case '2':
      if (nguoi.isEmpty) {
        print("Danh sách đang rỗng, không thể sửa.");
        break;
      }

      hienThiDanhSachNguoi(nguoi);
      stdout.write("Nhập ID người muốn sửa: ");
      int? idSua = int.tryParse(stdin.readLineSync() ?? '');
      if (idSua == null) {
        print("ID không hợp lệ!");
        break;
      }

      var index = nguoi.indexWhere((p) => p.id == idSua);
      if (index == -1) {
        print("Không tìm thấy người có ID $idSua.");
        break;
      }

      Person p = nguoi[index];

      print("Đang sửa thông tin người: ${p.name} (ID: ${p.id})");
      p.name = nhapTen("người");
      p.age = nhapTuoi();
      p.gender = nhapGioiTinh();

      if (p is Student) {
        //vấn đề kiểu động (runtime type) trong Dart.
        //Khi lưu cả Student và Teacher vào một List<Person>, biến lấy ra chỉ là Person,
        //nhưng Dart vẫn lưu kiểu thật của đối tượng.
        print("Sửa lớp (grade) của học sinh:");
        p.grade = nhapTen("lớp");

        print("Sửa điểm các môn:");
        p.score = nhapDiem();
      }

      if (p is Teacher) {
        print("Sửa môn dạy của giáo viên:");
        p.subject = nhapMonHoc();

        print("Sửa lương của giáo viên:");
        p.salary = nhapLuong();
      }

      print("Đã cập nhật thông tin cho ${p.name}.");
      break;
    case '3':
      if (nguoi.isEmpty) {
        print("Hiện không có người nào để xóa.");
        break;
      } else {
        hienThiDanhSachNguoi(nguoi);
        stdout.write("Nhập ID người muốn xóa: ");
        int? idXoa = int.tryParse(stdin.readLineSync() ?? '');
        if (idXoa == null) {
          print("ID không hợp lệ!");
          break;
        }

        // Tìm người theo ID bằng vòng for
        Person? personXoa;
        for (var p in nguoi) {
          if (p.id == idXoa) {
            personXoa = p;
            break;
          }
        }

        if (personXoa != null) {
          // Nếu là học sinh, xóa khỏi lớp
          if (personXoa is Student) {
            for (var lop in classrooms) {
              lop.students.remove(personXoa);
            }
          }

          // Nếu là giáo viên, gán teacher = null
          if (personXoa is Teacher) {
            for (var lop in classrooms) {
              if (lop.teacher == personXoa) {
                lop.teacher = null;
              }
            }
          }

          // Xóa khỏi danh sách chung
          nguoi.remove(personXoa);
          print("Đã xóa người có ID $idXoa: ${personXoa.name}");
        } else {
          print("Không tìm thấy người có ID $idXoa.");
        }
      }
      break;

    case '4':
      hienThiDanhSachNguoi(nguoi);
      break;

    default:
      print("Lựa chọn không hợp lệ!");
  }
}

void baoCaoLopHoc() {
  if (classrooms.isEmpty) {
    print("Hiện không có lớp nào trong hệ thống.");
    return;
  }

  print("\n------ Báo cáo danh sách lớp và điểm số ------");
  for (var lop in classrooms) {
    print("\nLớp ${lop.name} (ID: ${lop.id})");
    print(
      "Giáo viên: ${lop.teacher?.name ?? "Chưa có"} | Môn: ${lop.teacher != null ? lop.teacher!.subject.toString().split('.').last : "-"}",
    );

    if (lop.students.isEmpty) {
      print("Không có học sinh trong lớp.");
      continue;
    }

    print("Danh sách học sinh:");
    for (var hs in lop.students) {
      double tb = diemtb(hs);
      print(
        "- ${hs.name}, Tuổi: ${hs.age}, Giới tính: ${hs.gender.toString().split('.').last}, Điểm TB: ${tb.toStringAsFixed(2)}");
      print(
        "  Điểm cụ thể: Toán: ${hs.score[Subject.toan]}, Hóa: ${hs.score[Subject.hoa]}, Sinh: ${hs.score[Subject.sinh]}"
      );
    }
  }
  print("------------------------------------------------");
}

void main() {
  while (true) {
    print("\n===== MENU CHÍNH =====");
    print("1. Quản lý danh sách người");
    print("2. Báo cáo danh sách lớp và điểm số");
    print("3. Hiển thị đầy đủ học sinh và giáo viên theo ID lớp.");
    print("4. Thoát");
    stdout.write("Chọn chức năng (1-3): ");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        quanlyList();
        break;
      case '2':
        baoCaoLopHoc();
        break;
      case '3':
        hienThiLopTheoId();
        break;
      case '4':
        print("Thoát chương trình!");
        return;
      default:
        print("Lựa chọn không hợp lệ, vui lòng chọn lại.");
    }
  }
}
