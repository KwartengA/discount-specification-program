import 'dart:io';

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
