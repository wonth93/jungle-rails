describe("Product Details", function() {
  
  it("should visit home page", () => {
    cy.visit("/");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("click one of the product", () => {
    cy.get("[alt='Giant Tea']")
      .click();

    cy.get(".product-detail")
      .should('be.visible');
  });

});
