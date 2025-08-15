import 'dart:io';

class Product {
  String name;
  double cost;
  int number;

  Product(this.name, this.cost, this.number);

  void see() {
    print('Có $number sản phẩm tên "$name" có giá $cost');
  }

  void tangsl() => number++;

  void giamsl(int a) => number -= a;
}

String nhapTenSP() {
  while (true) {
    String? ten = stdin.readLineSync();
    if (ten == null || ten.isEmpty) {
      print('Tên sản phẩm không được để trống!');
      continue;
    }
    if (double.tryParse(ten) != null) {
      print('Tên sản phẩm không được toàn số!');
      continue;
    }
    return ten;
  }
}

double nhapGia(String mon) {
  while (true) {
    print('Nhập giá cho "$mon":');
    String? input = stdin.readLineSync();
    double? cost = double.tryParse(input ?? '');
    if (cost != null && cost >= 0) {
      return cost;
    }
    print("Giá không hợp lệ! Mời nhập lại:");
  }
}

int nhapSoLuongCanBan() {
  while (true) {
    String? input = stdin.readLineSync();
    int? so = int.tryParse(input ?? '');
    if (so == null || so <= 0) {
      print('Vui lòng nhập một số nguyên dương!');
      continue;
    }
    return so;
  }
}

void main() {
  List<Product> products = [
    Product('Kem duong da', 199.99, 18),
    Product('Mat da tay te bao chet', 200.99, 89),
    Product('May cao rau', 99.98, 400)
  ];

  while (true) {
    print('----------');
    print('1. Thêm sản phẩm');
    print('2. Hiển thị danh sách sản phẩm');
    print('3. Tìm kiếm sản phẩm theo tên');
    print('4. Bán sản phẩm');
    print('Khác: Thoát');
    print('Nhập lựa chọn:');
    int? k = int.tryParse(stdin.readLineSync() ?? '');

    if (k == null || (k != 1 && k != 2 && k != 3 && k != 4)) {
      print('Thoát chương trình.');
      break;
    }

    switch (k) {
      case 1:
        print('Nhập tên sản phẩm:');
        String ten = nhapTenSP();

        final existing = products.where((p) => p.name == ten);
        if (existing.isEmpty) {
          double cost = nhapGia(ten);
          products.add(Product(ten, cost, 1));
          print('Đã thêm sản phẩm "$ten" vào danh sách.');
        } else {
          existing.first.tangsl();
          print('Đã tăng số lượng sản phẩm "$ten".');
        }
        break;

      case 2:
        if (products.isEmpty) {
          print('Danh sách sản phẩm trống!');
        } else {
          products.forEach((p) => p.see());
        }
        break;

      case 3:
        print('Nhập tên sản phẩm cần tìm:');
        String ten = nhapTenSP();
        final sp = products.where((p) => p.name == ten); //Tra ve list
        if (sp.isEmpty) {
          print('Không tồn tại sản phẩm tên "$ten".');
        } else {
          sp.first.see();
        }
        break;

      case 4:
        print('Nhập tên sản phẩm cần bán:');
        String ten = nhapTenSP();
        final sp = products.where((p) => p.name == ten);
        if (sp.isEmpty) {
          print('Không tồn tại sản phẩm tên "$ten".');
        } else {
          final product = sp.first;
          print('Nhập số lượng cần bán:');
          while (true) {
            int number = nhapSoLuongCanBan();
            if (product.number < number) {
              print('Số lượng sản phẩm không đủ để bán! Nhập lại:');
              continue;
            }
            product.giamsl(number);
            print('Đã bán $number sản phẩm "$ten". Còn lại: ${product.number}');
            break;
          }
        }
        break;
    }
  }
}
