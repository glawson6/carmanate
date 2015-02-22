require 'rails_helper'

describe MaintenanceAction do
  let (:mreport) { {"id" => 10,
                    "model_year_id" => 123345,
                    "car_make_id" => 2345,
                    "engineCode" => 'gfre4',
                    "transmissionCode" => 'tran2',
                    "intervalMonth" => 12,
                    "intervalMileage" => 100000,
                    "frequency" => 6,
                    "partCostPerUnit" => 1.25,
                    "action" => 'replace hose',
                    "item" => 'hose',
                    "itemDescription" => 'dos some work on the hose',
                    "laborUnits" => 1.14,
                    "partsUnits" => 0.75,
                    "driveType" => 'hoser',
                    "modelYear" => '2001'
  }}
  let(:maintenace_action) { MaintenanceAction.create(
      { model_year_id: mreport["model_year_id"],
        car_make_id: mreport["car_make_id"],
        external_id: mreport["id"],
        engine_code: mreport["engineCode"],
        transmission_code: mreport["transmissionCode"],
        interval_month: mreport["intervalMonth"],
        interval_mileage: mreport["intervalMileage"],
        frequency: mreport["frequency"],
        part_cost_per_unit: mreport["partCostPerUnit"],
        action: mreport["action"],
        item: mreport["item"],
        item_description: mreport["itemDescription"],
        labor_units: mreport["laborUnits"],
        parts_units: mreport["partsUnits"],
        drive_type: mreport["driveType"],
        model_year: mreport["modelYear"]
      })}

  subject { maintenace_action }

  it { should respond_to(:model_year_id) }
  it { should respond_to(:car_make_id) }
  it { should respond_to(:external_id) }
  it { should respond_to(:engine_code) }
  it { should respond_to(:transmission_code) }
  it { should respond_to(:interval_month) }
  it { should respond_to(:interval_mileage) }
  it { should respond_to(:frequency) }
  it { should respond_to(:part_cost_per_unit) }
  it { should respond_to(:item) }
  it { should respond_to(:item_description) }
  it { should respond_to(:labor_units) }
  it { should respond_to(:parts_units) }
  it { should respond_to(:drive_type) }
  it { should respond_to(:model_year) }

  it { should be_valid }

  describe 'validations' do
    describe 'model_year_id' do
      context 'not present' do
        before { maintenace_action.model_year_id = nil }
        it { should_not be_valid }
      end
    end
  end
end