% Fictional data used to test the reservation policies.
% These patients and bed availability do not come from MIMIC-IV.
% Each shift represents an independent test case.

icu_bed(icu1).
icu_bed(icu2).

reserved_bed(icu2).

priority(alice, high).
priority(bob, standard).

shift(1).
shift(2).
shift(3).

% Case 1:
% Only icu2 is free and compatible with Bob.
% Reservation should prevent his admission.

candidate_bed(bob, icu2, 1).

% Case 2:
% Both beds are free and compatible with Bob.
% He may use icu1 even with reservation.

candidate_bed(bob, icu1, 2).
candidate_bed(bob, icu2, 2).

% Case 3:
% Only icu2 is free and compatible with Alice.
% Her high priority allows her to use the reserved bed.

candidate_bed(alice, icu2, 3).

% Bob has no candidate beds in shift 3.
% This alone does not establish reservation as the cause.