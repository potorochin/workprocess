-module (test).
-export ([xmlToProp/1, findXml/2, checkName/5, countList/2]).


xmlToProp(FileName) -> 
	io:format("~p~n", [FileName]),
	{ok, S} = 	file:read_file(FileName),

	%Rez = string:split(S, " ", all),
	Rez = string:split(S, "\n", all),
	%io:format("~p~n", [Rez]),


	io:format("~p~n", [lists:reverse(findXml(Rez, []))]),
	%%%%%%%%%%%%%% REZULTAT %%%%%%%%%%%%%%%%%%%
	lists:reverse(findXml(Rez, [])),
	%%%%%%%%%%%%%% REZULTAT %%%%%%%%%%%%%%%%%%%
	file:close(S).

	% motorcycles.xml

	findXml([], Acc) -> Acc;

	findXml([Head | Tail], Acc) -> 
		%io:format("~p~n", [Head]),
		StartPoint = binary:matches(Head, <<"<">>),
		EndPoint = binary:matches(Head, <<">">>),

		ListCheck = lists:reverse(checkName(StartPoint, EndPoint, 0, Head, [])),


		%io:format("~p~n", [ListCheck]),
		%if Rez3 > 0 -> 			io:format("YES");
		%true -> false		end,


		findXml(Tail, [ListCheck | Acc]).

%%%%%%%%%
% COUNTLIST
%%%%%%%%%		

	countList([], Acc) -> Acc;

	countList([_ | Tail], Acc) ->
		countList(Tail, Acc + 1).


%%%%%%%%%
%
%%%%%%%%%
	checkName([],[], _, _, Acc) -> Acc;

	checkName([Head1 | Tail1], [ Head2 | Tail2], BuffPoint, In, Acc) ->

		XmlFind = binary:matches(In, <<"?xml">>),
		DoctypeFind = binary:matches(In, <<"!DOCTYPE">>),

		FinderXml = countList(XmlFind, 0),
		FinderDoc = countList(DoctypeFind, 0),

		case FinderXml of
			1 -> checkName(Tail1, Tail2, 0, In, [binary:bin_to_list(In) | Acc]);
				0 ->

				case FinderDoc of
					1 -> checkName(Tail1, Tail2, 0, In, [binary:bin_to_list(In) | Acc]);
						0 -> 
							{Start, _ } = Head1,
							{End, _ } = Head2,

							
							RezKey =  binary:bin_to_list(In, {Start + 1,End - Start - 1}),
							if BuffPoint > 0 ->
								RezInf =  binary:bin_to_list(In, {BuffPoint, Start - BuffPoint  }),
								%io:format("~p~n", [RezInf]),
								checkName(Tail1, Tail2, End+1, In, [RezInf++RezKey | Acc]);
								
								BuffPoint == 0 ->
								checkName(Tail1, Tail2, End+1, In, [RezKey| Acc]);
								true -> false
							end
					end
		end.



