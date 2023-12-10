export const resource = (file) => `resource:///com/github/Aylur/ags/${file}.js`;
export const require = async (file) => (await import(resource(file))).default;
export const service = async (file) => await require(`service/${file}`);

export const App = await require("app");
export const Service = await require("service");
export const Utils = await import(resource("utils"));
export const Variable = await require("variable");
export const Widget = await require("widget");

// Services
export const Audio = await service("audio");
export const Battery = await service("battery");
export const Bluetooth = await service("bluetooth");
export const Hyprland = await service("hyprland");
export const Mpris = await service("mpris");
export const Network = await service("network");

// Variables
export const startDate = Date.now();
export const osdVars = Variable({
  reveal: Variable(false),
  debounceTimer: Date.now(),
  timePassed: 0,
  timeout: null,
  container: null,
});

export const player = Variable(Mpris.getPlayer(""));
export const musicVisible = Variable(false);

// Functions
globalThis.getPlayer = () => {
  console.log(`player: ${JSON.stringify(player.value)}`);
};

globalThis.setPlayer = () => {
  const player = Mpris.getPlayer("");
  const players = Mpris.players;
  console.log(`player: ${JSON.stringify(player)}`);
  console.log(`players: ${JSON.stringify(players)}`);
  player.value = player;
};
