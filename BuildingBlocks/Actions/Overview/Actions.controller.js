import PageController from "sap/fe/core/PageController";
import type Button from "sap/m/Button";
import MessageToast from "sap/m/MessageToast";
import type Table from "sap/m/Table";
import type UI5Event from "sap/ui/base/Event";
import type ODataV4Context from "sap/ui/model/odata/v4/Context";

/**
 * @namespace sap.fe.core.fpmExplorer.actions
 */
export default class Actions extends PageController {
	/**
	 * Invokes a custom action.
	 * @param context The binding context for the action
	 */
	public onExtensionActionPress(event: UI5Event<{}, Button>): void {
		const extensionAPI = this.getExtensionAPI();
		const selectedContexts = ((extensionAPI.byId("TableWithActions") as Table)?.getSelectedContexts() ?? []) as ODataV4Context[];
		const context = selectedContexts[0];
		this.editFlow
			.invokeAction("TravelService.Travel.AnnotationActionWithParameters", {
				contexts: selectedContexts.length > 0 ? selectedContexts : undefined,
				parameterValues: [{ name: "TotalPrice", value: context.getObject("TotalPrice") }],
				// Show the dialog in edit mode only
				skipParameterDialog: !extensionAPI.getModel("ui")?.getProperty("/isEditable")
			})
			.then(() => {
				MessageToast.show("Extension action successfully called.");
			});
	}
}
