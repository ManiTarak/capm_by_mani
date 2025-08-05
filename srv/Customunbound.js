module.exports = (srv) => {
  srv.on("exampleUnbound", () => {
    console.log("This is unbound function");
    return "unbound function";
  });
};
