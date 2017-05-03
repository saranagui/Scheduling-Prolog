/*The structure we used for the schedule is a list of timed events. 
Each timed event takes the Course, the group, the name of the event, 
the week,the day and the slot, in that order. The following is an example of a valid schedule*/

[timedEvent(csen401,group4MET,milestone1,20,thursday,1),timedEvent(csen401,group4MET,milestone2,19,thursday,1),timedEvent(csen401,group4MET,milestone3,18,thursday,1),timedEvent(csen401,group4MET,quiz1,17,thursday,1),timedEvent(csen401,group4MET,quiz2,15,thursday,1),timedEvent(csen401,group4MET,quiz3,13,thursday,1),timedEvent(csen402,group4MET,quiz1,16,thursday,1),timedEvent(csen402,group4MET,quiz2,14,thursday,1),timedEvent(csen402,group4MET,quiz3,12,thursday,1),timedEvent(csen403,group4MET,labquiz1,11,thursday,1),timedEvent(csen403,group4MET,labquiz2,10,thursday,1),timedEvent(csen403,group4MET,project1,9,thursday,1),timedEvent(csen403,group4MET,project2,20,tuesday,1),timedEvent(csen403,group4MET,quiz1,8,thursday,1),timedEvent(csen403,group4MET,quiz2,17,tuesday,1),timedEvent(csen403,group4MET,quiz3,19,tuesday,1),timedEvent(csen601,group6MET,project,20,saturday,5),timedEvent(csen601,group6MET,quiz1,19,saturday,5),timedEvent(csen601,group6MET,quiz2,17,saturday,5),timedEvent(csen601,group6MET,quiz3,15,saturday,5),timedEvent(csen602,group6MET,quiz1,18,saturday,5),timedEvent(csen602,group6MET,quiz2,16,saturday,5),timedEvent(csen602,group6MET,quiz3,14,saturday,5),timedEvent(csen603,group6MET,quiz1,13,saturday,5),timedEvent(csen603,group6MET,quiz2,11,saturday,5),timedEvent(csen603,group6MET,quiz3,9,saturday,5),timedEvent(csen604,group6MET,project1,12,saturday,5),timedEvent(csen604,group6MET,project2,10,saturday,5),timedEvent(csen604,group6MET,quiz1,8,saturday,5),timedEvent(csen604,group6MET,quiz2,6,saturday,5),timedEvent(csen604,group6MET,quiz3,2,saturday,5)].

/*given facts=the events in each course*/
event_in_course(csen403, labquiz1, assignment).
event_in_course(csen403, labquiz2, assignment).
event_in_course(csen403, project1, evaluation).
event_in_course(csen403, project2, evaluation).
event_in_course(csen403, quiz1, quiz).
event_in_course(csen403, quiz2, quiz).
event_in_course(csen403, quiz3, quiz).

event_in_course(csen401, quiz1, quiz).
event_in_course(csen401, quiz2, quiz).
event_in_course(csen401, quiz3, quiz).
event_in_course(csen401, milestone1, evaluation).
event_in_course(csen401, milestone2, evaluation).
event_in_course(csen401, milestone3, evaluation).

event_in_course(csen402, quiz1, quiz).
event_in_course(csen402, quiz2, quiz).
event_in_course(csen402, quiz3, quiz).

event_in_course(math401, quiz1, quiz).
event_in_course(math401, quiz2, quiz).
event_in_course(math401, quiz3, quiz).

event_in_course(elct401, quiz1, quiz).
event_in_course(elct401, quiz2, quiz).
event_in_course(elct401, quiz3, quiz).
event_in_course(elct401, assignment1, assignment).
event_in_course(elct401, assignment2, assignment).

event_in_course(csen601, quiz1, quiz).
event_in_course(csen601, quiz2, quiz).
event_in_course(csen601, quiz3, quiz).
event_in_course(csen601, project, evaluation).
event_in_course(csen603, quiz1, quiz).
event_in_course(csen603, quiz2, quiz).
event_in_course(csen603, quiz3, quiz).

event_in_course(csen602, quiz1, quiz).
event_in_course(csen602, quiz2, quiz).
event_in_course(csen602, quiz3, quiz).

event_in_course(csen604, quiz1, quiz).
event_in_course(csen604, quiz2, quiz).
event_in_course(csen604, quiz3, quiz).
event_in_course(csen604, project1, evaluation).
event_in_course(csen604, project2, evaluation).

/*given facts=all holidays in the schedule*/
holiday(3,monday).
holiday(5,tuesday).
holiday(10,sunday).

/*given facts=the courses studied by each group*/
studying(csen403, group4MET).
studying(csen401, group4MET).
studying(csen402, group4MET).
studying(csen402, group4MET).

studying(csen601, group6MET).
studying(csen602, group6MET).
studying(csen603, group6MET).
studying(csen604, group6MET).

/*givent facts=the events that should precede each other in each course*/
should_precede(csen403,project1,project2).
should_precede(csen403,quiz1,quiz2).
should_precede(csen403,quiz2,quiz3).

/*given facts=the available quiz slots for each group*/
quizslot(group4MET, tuesday, 1).
quizslot(group4MET, thursday, 1).
quizslot(group6MET, saturday, 5).

/*written facts=which day comes after the other in a week. 
Assume that weeks start with saturdays and end with fridays*/
after(sunday,saturday).
after(monday,sunday).
after(tuesday,monday).
after(wednesday,tuesday).
after(thursday,wednesday).
after(friday,thursday).

/*checks whether Day2 comes after Day1*/
after(Day2,Day1):-
	Day2\=Day1,
	after(Day2,Z),
	Day2\=Z,
	Z\=Day1,
	after(Z,Day1).
	
/*removes an element X from the list L1 to produce L2*/
remove(_,[],[]).
remove(X,L1,L2):- delete(L1,X,L2).

/*checks if all of the "should_precede" facts of the courses
studied by the group G are satisfied in the Schedule, by checking that none are not satisfied*/
precede(G,Schedule):-
	\+not_precede(G,Schedule).

/*checks if there is at least one "should_precede" fact of the courses
studied by the group G in the Schedule is not satisfied*/	
not_precede(G,Schedule):-
	Schedule\=[],
	Schedule\=[_],
	member(TE1,Schedule),
	member(TE2,Schedule),
	TE1\=TE2,
	studying(C,G),
	TE1=timedEvent(C,G, E1,Week1,Day1,Slot1),
	event_in_course(C,E1,_),
	TE2=timedEvent(C,G, E2,Week2,Day2,Slot2),
	event_in_course(C,E2,_),
	should_precede(C,E1,E2),
	\+((Week1<Week2);
	(Week1=Week2, Day1=Day2, Slot1<Slot2);
	(Week1=Week2, after(Day2,Day1))
	),!.
	
/*checks if the group G does not have more than one event in
any slot of Schedule. It checks if the schedule doesn't have any unvalid slots*/
valid_slots_schedule(G,Schedule):- 
	\+not_valid_slots_schedule(G,Schedule).
	
/*checks if the group G has more than one event in
any slot of Schedule*/
not_valid_slots_schedule(G,Schedule):-
	TE1=timedEvent(C1,G, _,Week,Day,Slot),
	member(TE1,Schedule),
	TE2=timedEvent(C2,G, _,Week,Day,Slot),
	member(TE2,Schedule),
	TE1\=TE2,
	studying(C1,G),
	studying(C2,G),!.

/*returns one of the available timings T of the group G in the structure timing(Day,Slot)*/
available_timings_help(G,T):- T=timing(Day,Slot),quizslot(G,Day,Slot).

/*returns all the available timings of the group G in the list L*/
available_timings(G,L):- setof(T,available_timings_help(G,T),L).

/*returns one of the available events E of the group G in the structure 
event(Course,EventName,EventType)*/
group_events_help(G,E):- E=event(Course, EventName, EventType),studying(Course,G), event_in_course(Course, EventName, EventType).

/*returns all the available events of the group G in the list Events*/
group_events(G,Events):- setof(E,group_events_help(G,E),Events).

/*checks if the group G does not have any two quizzes for the
same course in two consecitive weeks*/
no_consec_quizzes(G,Schedule):-
	\+consec_quizzes(G,Schedule).

/*checks if the group G has at least one case, where two quizzes for the
same course are scheduled in two consecitive weeks*/
consec_quizzes(G,Schedule):-
	TE1=timedEvent(C,G, E1,Week1,_,_),
	event_in_course(C,E1,quiz),
	member(TE1,Schedule),
	TE2=timedEvent(C,G, E2,Week2,_,_),
	event_in_course(C,E2,quiz),
	member(TE2,Schedule),
	TE1\=TE2,
	studying(C,G),
	Week2 is Week1 + 1 .

/*checks if group G does not have two quizzes scheduled on the same
day in Schedule*/
no_same_day_quiz(G,Schedule):-
	\+same_day_quiz(G,Schedule).

/*checks if group G has any two quizzes scheduled on the same
day in Schedule*/
same_day_quiz(G,Schedule):-
	TE1=timedEvent(C1,G, E1,Week,Day,_),
	event_in_course(C1,E1,quiz),
	member(TE1,Schedule),
	TE2=timedEvent(C2,G, E2,Week,Day,_),
	event_in_course(C2,E2,quiz),
	member(TE2,Schedule),
	TE1\=TE2,
	studying(C1,G),
	studying(C2,G).

/*checks if group G does not have two assignments scheduled on the same
day in Schedule*/
no_same_day_assignment(G,Schedule):-
	\+same_day_assignment(G,Schedule).
	
/*checks if group G has any two quizzes scheduled on the same
day in Schedule*/
same_day_assignment(G,Schedule):-
	TE1=timedEvent(C1,G, E1,Week,Day,_),
	event_in_course(C1,E1,assignment),
	member(TE1,Schedule),
	TE2=timedEvent(C2,G, E2,Week,Day,_),
	event_in_course(C2,E2,assignment),
	member(TE2,Schedule),
	TE1\=TE2,
	studying(C1,G),
	studying(C2,G).

/*checks if Schedule has no events scheduled in any of the available
holidays*/
no_holidays(G,Schedule):-
	\+holidays(G,Schedule).

/*checks if Schedule has at least one event scheduled in any of the available
holidays*/
holidays(G,Schedule):-
	TE1=timedEvent(C,G, _,Week,Day,_),
	member(TE1,Schedule),
	studying(C,G),
	holiday(Week,Day).

/*given a number of weeks Week_Number it returns a list of all numbers 
from 1 to Week_Number*/
allWeeks(0,[]).
allWeeks(Week_Number,[Week_Number|Weeks]):-
	Week_Number>0,
	Week_num_dec is Week_Number-1,
	allWeeks(Week_num_dec,Weeks).
	
/*given a certain number of weeks (Week_Number), 
it returns a Schedule with that many weeks. It gets all the Groups first, 
then the list of all available weeks (Weeks), and then generates the Schedule using
an accumulator*/
schedule(Week_Number,Schedule):-
	allgroups(Groups),
	allWeeks(Week_Number,Weeks),
	generate_Schedule(Weeks,[],Schedule,Groups).

/*generates the whole schedule for one given Group. Given the accumulator L, the list of
available weeks Weeks, the Group, the list of AvailableTimings of the group and the list of 
events for that group, it returns the schedule for that specific group (GroupSchedule)*/
generate_Group_Schedule(L,_,_,_,[],L).
generate_Group_Schedule(L,Weeks, Group, AvailableTimings, [E|Events], ScheduleOfOneGroup):-
	E=event(Course,EventName,T),
	member(timing(Day,Slot),AvailableTimings),
	member(Week,Weeks),
	TE=timedEvent(Course, Group, EventName,Week,Day,Slot),
	append(L,[TE],L1),
	precede(Group,L1),
	valid_slots_schedule(Group,L1),
	no_consec_quizzes(Group,L1),
	no_same_day_quiz(Group,L1),
	no_same_day_assignment(Group,L1),
	no_holidays(Group,L1),
	generate_Group_Schedule(L1,Weeks,Group,AvailableTimings,Events,ScheduleOfOneGroup).

/*returns all Groups, without repetition, that study any courses*/
allgroups(Groups):-
	findall(Group,studying(_,Group),DGroups),
	no_duplicates(DGroups,Groups).
	
/*removes all duplicates from a list*/
no_duplicates([],[]).
no_duplicates([X|L],[X|T]):-
	\+member(X,L),
	no_duplicates(L,T).
no_duplicates([X|L],T):-
	member(X,L),
	no_duplicates(L,T),!.
	
/*generates the whole Schedule using an accumulator L, by recursively going through 
the list of groups and creating and generating the GroupSchedule for each group*/
generate_Schedule(_,L,L,[]).
generate_Schedule(Weeks,L,Schedule,[Group|Groups]):-
	available_timings(Group,AvailableTimings),
	group_events(Group,Events),
	generate_Group_Schedule(L,Weeks,Group,AvailableTimings,Events,GroupSchedule),
	generate_Schedule(Weeks,GroupSchedule,Schedule,Groups).