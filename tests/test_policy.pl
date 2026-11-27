:- consult('../model/policies.pl').
:- consult('policy_scenario.pl').

query(eligible_under_policy(no_reservation, bob, icu2, 1)).

query(eligible_under_policy(with_reservation, bob, icu2, 1)).

query(eligible_under_policy(with_reservation, bob, icu1, 1)).

query(eligible_under_policy(with_reservation, alice, icu2, 3)).

query(prevented_by_reservation(with_reservation, bob, 1)).

query(prevented_by_reservation(no_reservation, bob, 1)).

query(prevented_by_reservation(with_reservation, bob, 2)).

query(prevented_by_reservation(with_reservation, alice, 3)).

query(prevented_by_reservation(with_reservation, bob, 3)).