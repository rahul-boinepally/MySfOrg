public with sharing class NewCaseListController {
	public List<Case> getNewCases() {

		List<Case> cases = [select Id, CaseNumber from Case where Status = 'New'];

		return cases;
	}
}