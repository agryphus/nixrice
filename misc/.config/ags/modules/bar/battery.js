const { exec, execAsync } = Utils;

export const Battery = () => Widget.Button({
    class_name: "battery",
    child: Widget.Label({
        setup: (self) => {self.poll(1000, (self) => 
            execAsync("block_battery")
                .then((out) => {
                    self.label = out;
                    let num = Number(out.substring(2, out.length - 1));

                    // Turn red at low battery
                    if (num < 20) {
                        self.class_name = "module, critical";
                    } else {
                        self.class_name = "module";
                    };
                })
                .catch(console.error),
        )},
    }),
    on_clicked: () => {},
});

