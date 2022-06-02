
function Game ()
    return {
        state = {
            MainMenu = true,
            OnePlayer = true,
            TwoPlayer = true,
            Controls = false
        },

        changeGameState = function (self, state)
            self.state.MainMenu = state == "MainMenu"
            self.state.OnePlayer = state == "OnePlayer"
            self.state.TwoPlayer = state == "TwoPlayer"
            self.state.Controls = state == "Controls"
        end
    }
end

return Game