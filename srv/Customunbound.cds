using {myFirstCdsViews} from '../db/CDS_VIEWS/First_CDS_Example.cds';
service customService @(path:'CustomService') {
    function exampleUnbound() returns String;
    //entity POWorkList as projection on myFirstCdsViews.POWorkList;
    entity ProdductOrders as projection on myFirstCdsViews.ProdductOrders;
}