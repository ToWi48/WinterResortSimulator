--
-- @autor Tom Wießner
-- @date 11/01/21
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

Demo = Demo or {};

function Demo:start()
    setIconState("Heat", "green");
    delay(10);
    setIconState("kompressor", "green");
    delay(10);
end;

inputEvent.add()