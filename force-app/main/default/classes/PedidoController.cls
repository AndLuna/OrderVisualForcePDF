public class PedidoController {
    // criamos as variaveis, observe que no caso de OrderItem abrimos uma lista
    public final Order pedido {get;set;}
    public final List<OrderItem> produtosDoPedido {get;set;}
    
    /* 1- definimos no construtor que as variaveis sao os metodos que criamos, para assim fazermos a
chamada na visual page

2 - note que criamos a variavel idDoPedido para guardar o resultado do metodo para pegar o id na URL, iremos utilizar
essa variavel na SOQL dos outros dois metodos getorders e getorderitems
*/
    public PedidoController(){
        String idDoPedido = getIdNaURL();
        pedido = getOrder(idDoPedido);
        produtosDoPedido = getProdutosDoPedido(idDoPedido);
    }
    
    //metodo para pegar o id do registro afim de criar o PDF dele
    public String getIdNaURL(){
        return ApexPages.currentPage().getParameters().get('id');
    }
    
    public Order getOrder(String idDoPedido){
        List<Order> pedidos = [SELECT OrderNumber, Status,
                               BillingStreet, CreatedDate, TotalAmount, 
                               ShippingStreet 
                               FROM Order WHERE Id = :idDoPedido]; // <<-- veja aqui a variavel que guarda o valor da url sendo chamada
        return pedidos.get(0);
    }
    
    public List<OrderItem> getProdutosDoPedido(String idDoPedido){
        List<OrderItem> items = [SELECT Product2.Name, Quantity,
                                 Product2.ProductCode, UnitPrice
                                 FROM OrderItem WHERE OrderId = :idDoPedido
                                ];
        //aqui criei uma logica de contador para exibir diretamente na visualPage, já que o campo ordenação não estava funcionando no registro
        /*    Integer contador = 1;
for(OrderItem item : items) {
item.Ordenacao__c = contador++;
}*/
        return items;
    }
}