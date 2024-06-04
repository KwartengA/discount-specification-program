import 'dart:io';

void main() {

  final products = {
    'Apple': 2.0,
    'Banana': 1.0,
    'Milk': 3.0,
    'Cornflakes':22.0,
    'Sugar':7.0,
    'Biscuits':5.0,
  };

  final employees = [
    Employee('Kenneth Okyere',3),
    Employee('Michael Owusu Sarpong',4),
    Employee('David Appiah',7),
  ];

  final affiliateList = {
    'John Doe': 'Cousin',
    'Alice Tenkorang': 'Sister',
    'Bob Brownstone': 'Stepbrother',
  };

  final employeeRelations = Map.fromIterable(
    affiliateList.keys,
    key: (employee) => employee,
    value: (employee) => affiliateList[employee],
  );

  stdout.write('Enter your name: ');
  String name = stdin.readLineSync()!;

  stdout.write('Enter the number of years as a customer/ an employee: ');
  int numberOfYears = int.parse(stdin.readLineSync()!);
   
   var productName = products;

    Map<String,int>cart = {};


    int chancesLeft = 3;
  while (chancesLeft > 0) {

    stdout.write('Enter product name (or type ''done'' to finish): ');
    String? productName = stdin.readLineSync();
    if (productName == 'done')
     break;

   if (products.containsKey(productName)) {
      stdout.write('Enter quantity: ');
      int quantity = int.parse(stdin.readLineSync()!);


 cart[productName!] = (cart[productName]??0) + quantity;
      
    } 
    else {
      print('Product not found. Please try again.');
      chancesLeft--;
      print('Chances left: $chancesLeft');
    }
  }


  Customer customer;
   if (employeeRelations.containsKey(name)) {
    customer = AffiliateCustomer(numberOfYears);
    }
 else if (numberOfYears >= 2) {
    customer = ConstantCustomers(numberOfYears);
  } 
  else {
    customer = RegularCustomers(numberOfYears);
  }


   double totalPrice = 0.0;
  cart.forEach((productName, quantity) {
    totalPrice += products[productName]! * quantity;
  });
  

  totalPrice = 0.0;
  cart.forEach((productName, quantity) {
    totalPrice += (products[productName]??0) * quantity;
  });
  
  double netTotal = totalPrice - customer.calculatediscount(totalPrice);

  print('Hello, $name!');
  // print($);
  print('Your Total Price: \GHC${totalPrice.toStringAsFixed(2)}');
  print('Your Net Total: \GHC${netTotal.toStringAsFixed(2)}');

}



abstract class Customer {
  double calculatediscount(double totalprice);
  int numberOfYears;
  Customer(this.numberOfYears){}
  
}

mixin InstanceCalculator{
  double calculateCombinediscount(double totalprice) {
   if (totalprice>=100) {
    return (totalprice ~/ 100) * 5;
   } else {
    return totalprice * 0.00;
   }
  }
  
}


mixin ProductCalculator{
  double calculatetheHighestDiscount(Customer customer, double totalprice, double calculateCombinediscount) {
  double maxDiscount = customer.calculatediscount(totalprice);
  if (calculateCombinediscount > maxDiscount) {
    maxDiscount = calculateCombinediscount;
  }
  return maxDiscount; 
}

 }


class RegularCustomers with ProductCalculator,InstanceCalculator implements Customer {
 int numberOfYears;

  @override
  double calculatediscount(double totalprice) => 0.0;
  RegularCustomers(this.numberOfYears){} 

}

class ConstantCustomers with ProductCalculator,InstanceCalculator implements Customer {
  int numberOfYears;
  
  @override
  double calculatediscount(double totalprice) {
    return 0.02 * totalprice;
  }
  ConstantCustomers(this.numberOfYears){}
}

class AffiliateCustomer with ProductCalculator,InstanceCalculator implements Customer {
  int numberOfYears;

  @override
  double calculatediscount(double totalprice) {
    return 0.03 * totalprice;
  }
  AffiliateCustomer(this.numberOfYears){} 
}

class Employee with ProductCalculator,InstanceCalculator implements Customer{
  int numberOfYears;

  @override
  double calculatediscount(totalprice){
    return 0.05 * totalprice ;
  }
   String fullName;
   Employee(this.fullName,this.numberOfYears){}
  
}


