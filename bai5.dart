// import 'dart:io';
//Bai tap toan tu dieu kien
class Employee {
  String name;
  int hour;
  double salary;

  Employee(this.name, this.hour, this.salary);
}
double tongluong(int hour, double salary){
    return hour*salary;
  }
double themPC(double tongluong, int hour){
  if(hour > 40){
    return tongluong*1.2;
  }
    return tongluong;
}
double truThue(double tongluong){
  if(tongluong > 10000000){
    return tongluong*=0.9;
  }
  else if(tongluong >= 7*1000000 && tongluong <= 10000000){
    return tongluong*=0.95;
  }
  else{
    return tongluong;
  }
}
void main() {
  Employee a = Employee('Khang', 36, 450000);
  Employee b = Employee('Phi Hoang Thao', 44, 60000);
  Employee c = Employee('That Dat Da', 28, 25000);
  var employees = {1: a, 2: b, 3: c};
  for(int i = 1; i < 4; i++){
    print('Ho ten: ${employees[i]!.name}');
    final tongluongTT = themPC(tongluong(employees[i]!.hour, employees[i]!.salary), employees[i]!.hour); 
    print('Tong luong truoc thue la: $tongluongTT');
    final thueTN = tongluongTT - truThue(tongluongTT);
    print('Thue thu nhap la: $thueTN');
    print('Luong thuc lanh la: ${truThue(tongluongTT)}');
    print('------------------');
  }
}
