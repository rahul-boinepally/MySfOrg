public class BankAcc {
	private integer balance=80;
	public string accName;
	public string accType;
	
	public void makeDeposit(integer deposit) {
		
				balance = balance + deposit;
				system.debug('test');
	}


	public integer getBalance() {
				return balance; 
	}

	
}