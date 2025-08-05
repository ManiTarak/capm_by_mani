module.exports = cds.service.impl(function () {
  const { PoItemsSet } = this.entities;
  this.on("boundedFunction", async (req) => {
    const ID = req.params[0];
    const tx = cds.tx(req);
    await tx
      .update(PoItemsSet)
      .with({
        GROSS_AMOUNT: { "+=": 20000 },
      })
      .where(ID);
  });

  this.on("largestOrder", async (req) => {
    const tx = cds.tx(req);
    const largestData = await tx
      .read(PoItemsSet)
      .orderBy({
        GROSS_AMOUNT: "desc",
      })
      .limit(1);
    return largestData;
  });
});
