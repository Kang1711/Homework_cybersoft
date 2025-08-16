
import 'dart:io';
class Product{
  String name;
  int number;
  double cost;

  Product(this.name, this.number, this.cost);
  void see(){
    print('Có $number sản phẩm "$name" với giá $cost trong giỏ hàng.');
  }
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

int nhapSoLuong() {
  while (true) {
    String? input = stdin.readLineSync();
    int? so = int.tryParse(input ?? '');
    if (so == null || so <= 0) {
      print('Vui lòng nhập một số nguyên duong!');
      continue;
    }
    return so;
  }
}
void addproduct(var a){
  print('Nhập tên sản phẩm:');
  String ten = nhapTenSP();
  print('Nhập số lượng sản phẩm:');
  int sl = nhapSoLuong();
  double gia = nhapGia(ten);
  int newKey = a.isEmpty ? 1 : a.keys.last + 1;
  a[newKey] = Product(ten, sl, gia);
  print('Đã thêm sản phẩm "$ten" vào giỏ hàng.');
}
void editproduct(var a){
  print('NHập tên sản phẩm muốn sửa.');
  var ten = nhapTenSP();
  bool check = a.values.any((p) => p.name == ten);
  if(check){
    print('Chọn 8 nếu muốn chỉnh sửa lại tên.');
    print ('Chọn 7 nếu muốn chỉnh sửa lại giá tiền.');
    print('Chọn 6 nếu muốn chỉnh sửa lại số lượng sản phẩm.');
    int k;
    while(true){
      k = nhapSoLuong();
      if(k != 8 && k != 7 && k != 6){
        print('Số không hợp lệ, nhập lại: ');
        continue;
      }
      break;
    }
    int keyTimThay = a.keys.firstWhere((key) => a[key]!.name == ten);
    Product c = a[keyTimThay];
    switch(k){
      case 8:
        print('Thay đổi tên sản phẩm ${c.name} thành: ');
        c.name = nhapTenSP();
        print('Đã thay đổi.');
        break;
      case 7:
        print('Thay đổi giá của sản phẩm ${c.name} từ (${c.cost}) thành: ');
        c.cost = nhapGia(c.name);
        print('Đã thay đổi giá.');
        break;
      case 6:
        print('Thay đổi số lượng sản phẩm ${c.name} từ ${c.number} thành: ');
        c.number = nhapSoLuong();
        break;
      default: break;
    }
  }
  else {
    print('Không tìm thấy tên sản phẩm trong giỏ hàng.');
  }
}
void hienthi(var a){
  a.forEach((key, value) => value.see());
}
double sum(var a){
  double tong = a.values.fold(0, (sum, p) => sum + p.cost * p.number);
  print('Tổng hóa đơn là: $tong');
  return tong;
}
void xoasp(var a){
  print('Nhập tên sản phẩm bạn muốn xóa.');
  var ten = nhapTenSP();
  bool check = a.values.any((p) => p.name == ten);
  if(check){
    a.removeWhere((key, product) => product.name == ten);
    print('Đã xóa sản phẩm $ten.');
  }
  else{
    print('Không tìm thấy sản phẩm tên $ten.');
  }
}
void main(){
  var a = {
    1: Product('Kem tay long nach', 99, 189.99),
    2: Product('Hu tro cot', 88, 149.99),
    3: Product('Silicon', 377, 49.99),
  };
  while(true){
    print('\n----------Chon---------');
    print('1. Thêm sản phẩm vào giỏ hàng.');
    print('2. Sửa sản phẩm ở giỏ hàng.');
    print('3. Xóa sản phẩm ở giỏ hàng.');
    print('4. Hiển thị giỏ hàng.');
    print('5. Tính tổng hóa đơn.');
    print('Số khác để thoát chương trình (trừ số 0).');
    int k = nhapSoLuong();
    if(k < 1 || k > 5){
      print('Thoát chương trình...');
      break;
    }
    if(k == 2 || k == 3 || k==4 || k==5){
      if(a.isEmpty){
        print('CẢNH BÁO! Không có sản phẩm nào trong giỏ hàng.');
        continue;
      }
    }
    switch (k){
      case 1: addproduct(a); break;
      case 2: editproduct(a); break;
      case 3: xoasp(a); break;
      case 4: hienthi(a); break;
      case 5: sum(a); break;
      default: break;
    }
  }
}