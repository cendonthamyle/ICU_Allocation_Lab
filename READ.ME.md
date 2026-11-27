## Reservation policies

The `model/policies.pl` file defines ICU bed eligibility under two policies:

- `no_reservation`: both priority groups may use any ICU bed.
- `with_reservation`: one ICU bed is reserved for high-priority patients. Standard-priority patients may only use non-reserved beds.

These rules apply to new allocations. Patients who remain hospitalized keep their beds.

### Required inputs

The scenario must provide:

| Predicate | Meaning |
| --- | --- |
| `priority(Patient, Group)` | Patient priority: `high` or `standard`. |
| `icu_bed(Bed)` | Identifies an ICU bed. |
| `reserved_bed(Bed)` | Identifies the reserved ICU bed. |
| `shift(Shift)` | Identifies a simulation shift. |

The allocation module must provide:

```prolog
candidate_bed(Patient, Bed, Shift).
```

A candidate bed must be free and compatible with the patient at the moment of that patient's allocation decision, after departures and earlier allocations have been processed.

The scenario must identify exactly one reserved ICU bed. This is an input requirement; the policy module does not validate it automatically.

### Main predicates

```prolog
eligible_under_policy(Policy, Patient, Bed, Shift).
```
```prolog
blocked_by_reservation(Policy, Patient, Bed, Shift).
```
```prolog
prevented_by_reservation(Policy, Patient, Shift).
```

The first onde determines whether the policy permits the patient to use the bed. Eligibility alone does not establish availability, compatibility, or allocation. The following identifies a standard-priority patient blocked from using the reserved bed under `with_reservation`. And the last one holds when at least one candidate bed is blocked by reservation and no candidate bed is allowed by the policy.

If another free and compatible bed is permitted, reservation does not prevent admission. If there are no candidate beds, this predicate does not attribute the lack of admission to reservation.



### Integration

The allocation module combines candidate beds with policy eligibility to select a destination. It is also responsible for priority ordering, tie-breaking, and preventing double occupancy.

When reservation actually causes an external transfer, the allocation module should record:

```prolog
transferred(Patient, Shift, reservation).
```



Note: The policy module identifies the reservation restriction; it does not allocate beds or record transfers itself. The full multi-shift reservation test requires integration with the allocation and patient-evolution modules.