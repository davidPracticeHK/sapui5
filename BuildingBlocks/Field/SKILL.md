---
name: sap-cap-fields-implementer
description: Use this skill when implementing SAP CAP field features in Fiori elements, especially value help via Common.ValueList and MultiValueField (multi-input/token) patterns with proper CDS annotations, mappings, and metaPath wiring.
---

# SAP CAP Fields Implementer

Use this skill to implement field-centric UX in SAP CAP + Fiori elements based on the examples in this folder.

## When to use

Trigger this skill when the user asks to:
- add or fix value help for fields (`Common.ValueList*`)
- configure in/out/display mappings in value help dialogs
- implement context-dependent or qualifier-based value helps
- implement FE `macros:MultiValueField` (multi-input token fields)
- bind fields via direct property path or annotation `DataField` metaPath

## Workflow

1. **Choose pattern family**
   - Value-help heavy scenarios: use `InputWithValueHelp` patterns.
   - Multi-token 1:n scenarios: use `MultiInputField` patterns.

2. **Model/extend service entities**
   - Ensure target properties and associations exist for text/value resolution.
   - For MVF, expose a target property with a value list on the child entity.
   - References: `MultiInputField/localService.cd`, `InputWithValueHelp/inputValueHelp.cds`.

3. **Annotate fields with the right ValueList flavor**
   - Basic value help: `Common.ValueList`.
   - Fixed values/dropdown: `Common.ValueListWithFixedValues`.
   - Validation on input: `Common.ValueListForValidation`.
   - Context-dependent variants: `Common.ValueListRelevantQualifiers` + qualified `ValueList` entries.
   - Use `ValueListParameterInOut`, `In`, `Out`, and `DisplayOnly` intentionally.
   - Reference: `references/value-help-patterns.md`.

4. **Wire UI field groups / line items**
   - Add fields to `UI.FieldGroup` / `UI.LineItem` where they should render.
   - For MVF via annotations, point `metaPath` to `FieldGroup` DataField when needed.
   - References: `MultiInputField/annotations.cds`, `MultiInputField/FieldMultiValueField.view.xml`.

5. **Implement FE macro usage (MVF)**
   - Use `<macros:MultiValueField metaPath="..." readOnly="..." />`.
   - For custom token sources, bind `items` to a JSON model (demo pattern).
   - Prefer annotation-based table rendering for performance; avoid per-row custom-column value helps unless row count is constrained.
   - References: `MultiInputField/FieldMultiValueField.view.xml`, `MultiInputField/FieldMultiValueField.controller.ts`.

6. **Sanity checks**
   - Validate namespace/path consistency across service + annotations + XML metaPath.
   - Verify `LocalDataProperty` and `ValueListProperty` mapping pairs.
   - Test empty/null and edit/read-only states.

## Implementation checklist

- [ ] Field property exists and has correct type/association context.
- [ ] Correct value-help annotation strategy selected.
- [ ] In/Out/DisplayOnly mapping aligns to business intent.
- [ ] Any qualifier logic is deterministic and testable.
- [ ] MVF `metaPath` resolves to property or DataField annotation.
- [ ] Read-only/edit mode behavior is intentional.
- [ ] Table usage follows performance guidance.

## File map for targeted loading

- **Value help patterns and examples**: `references/value-help-patterns.md`
- **Multi-input field usage patterns**: `references/multi-input-field-patterns.md`
- **Comprehensive value-help demo model**: `InputWithValueHelp/inputValueHelp.cds`
- **MVF view/controller implementation**: `MultiInputField/FieldMultiValueField.view.xml`, `MultiInputField/FieldMultiValueField.controller.ts`
- **MVF service extension**: `MultiInputField/localService.cd`

## Notes

- Prefer the minimal annotation set that meets UX needs; over-qualifying value lists can make maintenance hard.
- For dependent value helps, keep source and dependent fields close in the same field group.
- Keep action-like behavior out of field annotations; use dedicated action patterns separately.
