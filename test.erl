-module (test).
-export ([xmlToProp/1, findXml/2, checkName/5, convertXml/4, propToXml/2]).


xmlToProp(FileName) -> 
	{ok, S} = 	file:read_file(FileName),
	Rez = string:split(S, "\n", all),


	%%%%%%%%%%%%%% REZULTAT %%%%%%%%%%%%%%%%%%%
	convertXml(lists:reverse(findXml(Rez, [])), [], [], []).

	%%%%%%%%%%%%%% REZULTAT %%%%%%%%%%%%%%%%%%%
	

	findXml([], Acc) -> Acc;

	findXml([Head | Tail], Acc) -> 
		%io:format("~p~n", [Head]),
		StartPoint = binary:matches(Head, <<"<">>),
		EndPoint = binary:matches(Head, <<">">>),
 
		ListCheck = lists:reverse(checkName(StartPoint, EndPoint, 0, Head, [])),
<<<<<<< HEAD
		
=======

>>>>>>> ec30cc16fb7d395872aea4f7800003063c3c5b76
		findXml(Tail, [ListCheck | Acc]).
%%%%%%%%%
%
%%%%%%%%%
	checkName([],[], _, _, Acc) -> Acc;

	checkName([Head1 | Tail1], [ Head2 | Tail2], BuffPoint, In, Acc) ->

		XmlFind = binary:matches(In, <<"?xml">>),
		DoctypeFind = binary:matches(In, <<"!DOCTYPE">>),

		FinderXml = countList(XmlFind, 0),
		FinderDoc = countList(DoctypeFind, 0),

		case FinderXml of %CHECKER OFF
			1 -> checkName(Tail1, Tail2, 0, In, Acc);
				0 ->

				case FinderDoc of
					1 -> checkName(Tail1, Tail2, 0, In, Acc);
						0 -> 
							{Start, _ } = Head1,
							{End, _ } = Head2,

							case lists:nthtail(1, string:split(In, "/", all)) of
								[<<">">>] -> %%%%% THIS THING
			findHardTag(string:split(In, " ", all),0,[],[]);
								_ -> false
							end,

							
							RezKey =  binary:bin_to_list(In, {Start + 1,End - Start - 1}),
							if BuffPoint > 0 ->
								RezInf =  binary:bin_to_list(In, {BuffPoint, Start - BuffPoint  }),
								
								checkName(Tail1, Tail2, End+1, In, [RezInf++RezKey | Acc]);
								
								BuffPoint == 0 ->
								checkName(Tail1, Tail2, End+1, In, [RezKey| Acc]);
								true -> false
							end
					end
		end.

	convertXml([], _, _, Acc) -> Acc;

	convertXml([Head | Tail], Buff, BuffValue, Acc) -> 

		case countList(Head, 0) of	
			1 -> 
				[Tag] = Head,
				case countList(string:split(Tag, "/", all) , 0) of
					1 -> 
<<<<<<< HEAD
						CheckTag = erlang:length(string:split(Tag, " ", all)),
						case CheckTag > 1 of

=======

								%%%%%%%%%%%%%%%%%%%%%%
								% add check atribute
								%%%%%%%%%%%%%%%%%%%%%%

						%countList(string:split(Tag, " ", all)
						CheckTag = erlang:length(string:split(Tag, " ", all)),
						case CheckTag > 1 of
							%% {"year=\"2000\"","color=\"black\""} %%%
>>>>>>> ec30cc16fb7d395872aea4f7800003063c3c5b76
							true -> [ DeleteTag | NeedText] = string:split(Tag, " ", all),
							convertXml(Tail, Buff, [ {erlang:list_to_atom(DeleteTag) , findValue(NeedText, [])} | BuffValue], Acc);
							false -> convertXml(Tail, Buff, BuffValue, Acc)
						end;
						% add tag
					2 -> 
						[_, Tagers] = string:split(Tag, "/", all),

						case is_empty_list(Buff) of
							false -> convertXml(Tail, Buff, BuffValue, {Tagers, Acc});
							true -> 
								case proplists:delete(erlang:list_to_atom(Tagers), BuffValue) == BuffValue of
									false -> 
								convertXml(Tail, 
									[], 
									proplists:delete(erlang:list_to_atom(Tagers), BuffValue),
									[ {erlang:list_to_atom(Tagers), proplists:get_value(erlang:list_to_atom(Tagers), BuffValue),lists:reverse(Buff)} | Acc] );

									true ->
								convertXml(Tail, [],	BuffValue,						 
								[{erlang:list_to_atom(Tagers),lists:reverse(Buff)} | Acc]) %add tag, confirm Acc

						%delete tag/value
<<<<<<< HEAD
								end
=======
					end
>>>>>>> ec30cc16fb7d395872aea4f7800003063c3c5b76
						end
						
				end;

			2 ->
				[Tag, Value] = Head, 
				ValueTag = string:split(Value, "/", all),
				[NeedValue, _] = ValueTag,
				convertXml(Tail, [{erlang:list_to_atom(Tag), NeedValue} | Buff], BuffValue, Acc);
			0 -> convertXml(Tail, Buff, BuffValue, Acc)
		end.

		findValue([], Acc) -> Acc;

		findValue([Head | Tail],  Acc) ->
			
			InputList = (string:split(Head, "\"")),
			[Tag, Value] = InputList,
			findValue(Tail, [
				{erlang:list_to_atom(lists:reverse(lists:nthtail(1, lists:reverse(Tag)))), 
				erlang:list_to_atom(lists:reverse(lists:nthtail(1, lists:reverse(Value))))} | Acc]).

<<<<<<< HEAD

		findHardTag([], _, _, Acc) -> 
		io:format("~p~n", [lists:reverse(Acc)]), lists:reverse(Acc);	

		findHardTag([Head | Tail], Counter, Buff, Acc) ->
			case Counter of
				0 -> 
				case Head == <<>> of
					true -> findHardTag(Tail, 0, Buff, Acc);
					false ->  Tag = Head,
					findHardTag(Tail, 1, Buff, [ erlang:list_to_atom(lists:nthtail(1, binary_to_list(Tag)))| Acc])
				end;

				_ -> 
					case Counter rem 2 of
						1 -> findHardTag(Tail, Counter+1, Head, Acc);
						0 -> 
						binary_to_list(Head),
						findHardTag(Tail, Counter+1, [], 
							[binary_to_list(Head), %%%% Added pars head
							% [brandName,value,<<"\"Suzukies\"/>">>]
							% [additionalName,value,<<"\"Intruder\"/>">>]

							erlang:list_to_atom(lists:reverse(lists:nthtail(1, lists:reverse(binary_to_list(Buff)))))| Acc])
					end

			end.

=======
>>>>>>> ec30cc16fb7d395872aea4f7800003063c3c5b76
%%%%%%%%%
% COUNTLIST
%%%%%%%%%		

	countList([], Acc) -> Acc;

	countList([_ | Tail], Acc) ->
		countList(Tail, Acc + 1).

%%%%%%%%%
%	EMPTY_LIST
%%%%%%%%%

	is_empty_list([]) -> false;
	is_empty_list(_) -> true.

%%%%%%%%%%
%
%%%%%%%%%%




	propToXml(List, FileName) ->

		{ok, S} = file:open(FileName, write),
	%%lists:foreach(fun(X) -> io:format(S, "~p~n" ,[X]) end, [hello]),
	file:close(S).


	goFromText([], _, Acc)-> Acc;

	goFromText([Head, Tail], S, Acc) ->
		[{Tag, Value}] = Head.

