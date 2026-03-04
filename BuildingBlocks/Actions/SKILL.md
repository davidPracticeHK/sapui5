---
name: sap-cap-actions-implementer
description: Use this skill when implementing SAP CAP OData actions in Fiori elements apps, including CDS action definitions, UI annotations (DataFieldForAction, DataFieldWithAction, action groups, inline actions, AI actions), and controller extension invokeAction flows with parameters.
---

# SAP CAP Actions Implementer

Use this skill to implement or extend SAP CAP + Fiori elements action patterns like the examples in `Overview/`.

## When to use

Trigger this skill when the user asks to:
- add actions to a list report/object page
- define CAP actions and expose them in FE UI annotations
- add inline/menu/AI actions
- invoke parameterized OData actions from a controller extension

## Workflow

1. **Model actions in CDS service extension**
   - Add actions under `extend <Service>.<Entity> with actions`.
   - For AI-style actions, annotate with `@UI.IsAIOperation: true`.
   - Reference: `Overview/extendedService.cds`.

2. **Wire actions into UI annotations**
   - Toolbar action: `UI.DataFieldForAction`.
   - Inline table action: `UI.DataFieldForAction` + `Inline: true`.
   - Action on field value: `UI.DataFieldWithAction`.
   - Grouped menu actions: `UI.DataFieldForActionGroup` with nested actions.
   - Reference: `Overview/extendedService.cds`.

3. **Ensure entity/service metadata is complete**
   - Verify entity fields, associations, and relevant value-help/status annotations.
   - Keep `@UI.LineItem`, field groups, header/facets coherent with action placement.
   - Reference: `Overview/service.cds`, `Overview/annotations.cds`.

4. **Implement extension controller action invocation (if required)**
   - Use `this.editFlow.invokeAction("<Service>.<Entity>.<Action>", {...})`.
   - Pass selected contexts and `parameterValues` for parameterized actions.
   - Optionally control `skipParameterDialog` based on edit mode.
   - Reference: `Overview/Actions.controller.js`.

5. **App wiring checks**
   - Validate manifest datasource, route, view name, and context path.
   - Reference: `Overview/manifest.json`.

6. **Mock-data sanity checks (demo scenarios)**
   - Ensure test records include values used by actions (for example `TotalPrice`).
   - Reference: `Overview/Travel.json`.

## Implementation checklist

- [ ] Action declared in CDS with correct namespace and parameters.
- [ ] Action appears in desired UI location (toolbar, inline, field, menu).
- [ ] Labels and UX semantics are clear (`@UI.IsAIOperation` when needed).
- [ ] Controller invoke path matches exact fully qualified action name.
- [ ] Parameter mapping and selected contexts are robust.
- [ ] Manifest routing and context path resolve correctly.

## File map for targeted loading

- **Action patterns**: `references/action-patterns.md`
- **Controller invokeAction pattern**: `Overview/Actions.controller.js`
- **Service model baseline**: `Overview/service.cds`
- **General FE annotations baseline**: `Overview/annotations.cds`
- **Demo app shell**: `Overview/manifest.json`

## Notes

- Prefer extending existing entity annotations instead of duplicating line items.
- Keep action names consistent across CDS declarations and UI annotation `Action` paths.
- For parameterized actions, decide whether dialog entry is needed or parameters should be supplied programmatically.
