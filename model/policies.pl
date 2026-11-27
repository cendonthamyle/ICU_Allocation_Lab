% ICU bed reservation policies.
%
% Scenario inputs:
%   priority(Patient, Group).
%   icu_bed(Bed).
%   reserved_bed(Bed).
%   shift(Shift).
%
% Allocation input:
%   candidate_bed(Patient, Bed, Shift).
%
% A candidate bed is free and compatible with the patient
% at the moment of the allocation decision.


priority_group(high).
priority_group(standard).

eligible_under_policy(no_reservation, Patient, Bed, Shift) :-
    priority(Patient, Group),
    priority_group(Group),
    icu_bed(Bed),
    shift(Shift).

eligible_under_policy(with_reservation, Patient, Bed, Shift) :-
    priority(Patient, high),
    icu_bed(Bed),
    shift(Shift).

eligible_under_policy(with_reservation, Patient, Bed, Shift) :-
    priority(Patient, standard),
    icu_bed(Bed),
    shift(Shift),
    \+ reserved_bed(Bed).



blocked_by_reservation(with_reservation, Patient, Bed, Shift) :-
    priority(Patient, standard),
    icu_bed(Bed),
    reserved_bed(Bed),
    shift(Shift).

has_allowed_bed(Policy, Patient, Shift) :-
    candidate_bed(Patient, Bed, Shift),
    eligible_under_policy(Policy, Patient, Bed, Shift).

has_blocked_bed(Policy, Patient, Shift) :-
    candidate_bed(Patient, Bed, Shift),
    blocked_by_reservation(Policy, Patient, Bed, Shift).


% Reservation prevents admission when a candidate bed
% is blocked and no candidate bed is allowed.

prevented_by_reservation(Policy, Patient, Shift) :-
    has_blocked_bed(Policy, Patient, Shift),
    \+ has_allowed_bed(Policy, Patient, Shift).