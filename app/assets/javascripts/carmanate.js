
function createModelTableRow(results){
    var carModelTr = $('#car-model-tr');
    var carMakeTr = $('#car-make-tr');
    if (carModelTr.html() === undefined){
        console.log("In here?");
        var tr = $("<tr></tr>").attr({"id":"car-model-tr"});
        //tr.appendTo(carMakeTableTB);
        var td = $("<td></td>");
        var label = $("<label></label>").attr({"for":"model"}).text("Model:");
        td.append(label);
        tr.append(td);
        td = $("<td></td>");
        var select = $("<select></select>").attr({"id":"model_select","class":"form-control","name":"car_profile[model]"});
        td.append(select);
        tr.append(td);
        tr.insertAfter(carMakeTr);
    }
    $('#model_select').find('option').remove();
    $(results["model_names"]).each(function() {
        var option = $("<option>").attr('value',this).text(this);
        $('#model_select').append(option);
    });
    $('#model_select').val(results["model"]);
}

function createYearTableRow(results){
    var carYearTr = $('#car-year-tr');
    var carModelTr = $('#car-model-tr');
    if (carYearTr.html() === undefined){
        var tr = $("<tr></tr>").attr({"id":"car-year-tr"});
        var td = $("<td></td>");
        var label = $("<label></label>").attr({"for":"year"}).text("Year:");
        td.append(label);
        tr.append(td);
        td = $("<td></td>");
        var select = $("<select></select>").attr({"id":"year_select","class":"form-control","name":"car_profile[year]"});
        td.append(select);
        tr.append(td);
        tr.insertAfter(carModelTr);
    }

    $('#year_select').find('option').remove();
    $(results["years"]).each(function() {
        var option = $("<option>").attr('value',this).text(this);
        $('#year_select').append(option);
    });
    $('#year_select').val(results["year"]);
    console.log("Year "+results["year"]+" Years "+results["years"]);
    $('#year_select').change(function() {
        console.log("Year => "+$('#year_select').val());
        $.ajax({
            url: "/make/model/year",
            data: {
                model : $('#model_select').val(),
                make : $('#make_select').val(),
                year  : $('#year_select').val()
            },
            dataType: "json",
            success: function(results){
                updateMakeModelYearInfo(results);
            }
        });
    });

}

function createEngineCodeTableRow(results){
    var carYearTr = $('#car-year-tr');
    var carEngineCodeTr = $('#car-engine-code-tr');
    if (carEngineCodeTr.html() === undefined){
        console.log("In here?");
        var tr = $("<tr></tr>").attr({"id":"car-engine-code-tr"});
        var td = $("<td></td>");
        var label = $("<label></label>").attr({"for":"engine_code"}).text("Engine Code:");
        td.append(label);
        tr.append(td);
        td = $("<td></td>");
        var select = $("<select></select>").attr({"id":"engine_code_select","class":"form-control","name":"car_profile[engine_code]"});
        td.append(select);
        tr.append(td);
        tr.insertAfter(carYearTr);
    }

    $('#engine_code_select').find('option').remove();
    $(results["engine_codes"]).each(function() {
        var option = $("<option>").attr('value',this).text(this);
        $('#engine_code_select').append(option);
    });
    $('#engine_code_select').val(results["engine_code"]);
}
function updateMakeModelYearInfo(results){
    var carMakeTableTB = $('#carMakeTableTB');
    $('#make_select').find('option').remove();
    $(results["make_names"]).each(function() {
        $('#make_select').append($("<option>").attr('value',this).text(this));
    });
    $('#make_select').val(results["make"]);
    createModelTableRow(results);
    createYearTableRow(results);
    createEngineCodeTableRow(results);
}
