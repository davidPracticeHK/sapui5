import PageController from "sap/fe/core/PageController";
import JSONModel from "sap/ui/model/json/JSONModel";

export default class FieldMultiValueFieldController extends PageController {
	public onInit(): void {
		super.onInit();
		const uiModel = this.getView().getModel("ui") as JSONModel;
		uiModel.setProperty("/isEditable", true);

		const jsonModel = new JSONModel();
		this.getView().setModel(jsonModel, "jsonModel");
		jsonModel.setProperty("/Agencies", [
			{
				AgencyID: "070011",
				Name: "Voyager Enterprises"
			},
			{
				AgencyID: "070012",
				Name: "Ben McCloskey Ltd."
			}
		]);
	}

	public onToggleEdit(): void {
		const uiModel = this.getView().getModel("ui") as JSONModel;
		const editable = !!uiModel.getProperty("/isEditable");
		uiModel.setProperty("/isEditable", !editable);
	}
}
