-module (test).
-export ([xmlToProp/1, findXml/2, countList/2]).


xmlToProp(FileName) -> 
	io:format("~p~n", [FileName]),
	{ok, S} = 	file:read_file(FileName),

	Rez = string:split(S, "\n", all),

	findXml(Rez, []),
	
	file:close(S).

	% motorcycles.xml

	findXml([], Acc) -> Acc;

	findXml([Head | Tail], Acc) -> 
		io:format("~p~n", [Head]),
		StartPoint = binary:matches(Head, <<"<">>),
		EndPoint = binary:matches(Head, <<">">>),
		EndStart = binary:matches(Head, <<"</">>),
		
		Rez1 = countList(StartPoint, 0),
		Rez2 = countList(EndPoint, 0),
		Rez3 = countList(EndStart, 0),

		if Rez1 > 0 -> 			io:format("YES");
		true -> false		end,


		findXml(Tail, Acc).

%%%%%%%%%
% 
%%%%%%%%%

	countList([], Acc) -> Acc;

	countList([_ | List], Acc) ->
		countList(List, Acc+1).

%%%%%%%%%
% 
%%%%%%%%%		


