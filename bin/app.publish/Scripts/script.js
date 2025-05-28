function prueba() {
    alert("Entro");
}
function SeleccionarTipo() {

    //var e = document.getElementById("ddlLocation");
    //var selectedLocation = e.options[e.selectedIndex].value;
    var tipo = document.getElementById("ddTipo").value;
    //console.log(tipo)
    var precio;
    switch (tipo) {
        case "0":
            document.getElementById("lblPedido5").hidden = true;
            break;
        case "1":
            precio = "$500";
            break;
        case "2":
            precio = "$700";
            break;
        case "3":
            precio = "$1000";
            break;
    }

}
function validalargo() {
    var lote = document.getElementById("txtLote").value
    if (lote.length !=3) {
        alert("El Campo Lote debe ser de 3 caracteres");
        document.getElementById("txtLote").value = ""
    }
}