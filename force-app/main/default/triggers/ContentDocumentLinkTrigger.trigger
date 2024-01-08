trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert) {
    ContentDocumentLink_ProductsImg.updateProductImageId(Trigger.new);
}