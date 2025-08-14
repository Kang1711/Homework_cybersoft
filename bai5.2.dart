// import 'dart:io';
//Bai tap toan tu dieu kien
class Product {
  String name;
  int numberBuy;
  double cost;

  Product(this.name, this.numberBuy, this.cost);
}
double totalCost(double cost, int number) => cost * number;
double discount(double total){
  if(total >= 1000000){
    return total*0.9;
  }
  else if(total < 1000000 && total >= 500000){
    return total*0.95;
  }
  return total;
}
double sauVat(double total) => total*0.92;
void main() {
  Product a = Product('Khang', 36, 450000);
  Product b = Product('Phi Hoang Thao', 44, 6000);
  Product c = Product('That Dat Da', 55, 12000);
  var products = {1: a, 2: b, 3: c};
  for(int i = 1; i <4; i++){
    print('Ten san pham: ${products[i]!.name}, so luong mua: ${products[i]!.numberBuy}, don gia: ${products[i]!.cost}');
    final total = totalCost(products[i]!.cost, products[i]!.numberBuy);
    print('Thanh tien: $total');
    final giamgia = total - discount(total);
    print('Giam gia: $giamgia');
    final thueVat = discount(total)*0.08;
    print('Thue Vat 8% la: $thueVat');
    final thanhtien = sauVat(discount(total));
    print('Tong thanh toan cuoi cung: $thanhtien');
    print('-------------------');
  }
}
