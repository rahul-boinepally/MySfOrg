public class EightQueenPuzzleCheck {

    public static Map<string, integer> maps = new Map<string, integer>();
    public EightQueenPuzzleCheck()
    {    	
        maps.put('a',1);
		maps.put('b',2);
		maps.put('c',3);
		maps.put('d',4);
		maps.put('e',5);
		maps.put('f',6);
		maps.put('g',7);
		maps.put('h',8);
    }

    public static Map<string, string> checkValid(String input)
    {
    	string a = input.substring(0,1);
    	integer b = integer.valueOf(input.substring(1,2));

		set<string> existingValues = new set<string>();

		Map<string, string> retMap = new Map<string, string>();

		if(existingValues.size() > 0){
			for(string s: existingValues){
				if(s.substring(0,1) == a){
					// invalid - vertical
					retMap.put('error', input);
					return retMap;
				}

				if(integer.valueOf(s.substring(1,2)) == b){
					// invalid - horizantal
					retMap.put('error', input);
					return retMap;
				}

				/* check for diagonal */

				if(maps.get(a) - maps.get(s.substring(0,1)) ==  b - integer.valueOf(s.substring(1,2)) ){

					retMap.put('error', input);
					return retMap;

				}
			}


		}else{
			existingValues.add(input);
			retMap.put('valueAdded', input);

		}

//		retMap.put('input_ok', input);

		return retMap;
    }
}