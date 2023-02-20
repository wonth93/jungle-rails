describe("Product Details", function() {
  
  it("should visit home page", () => {
    cy.visit("/");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("click one of the product", () => {
    cy.get("[alt='Scented Blade']")
      .click();

    cy.get(".product-detail")
      .should('be.visible');
  });

  it("add to cart", () => {
    cy.contains('Add')
      .click();
    cy.contains("My Cart (1)")
      .should('be.visible');
  });

});
