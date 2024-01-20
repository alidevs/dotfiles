local present, dropbar = pcall(require, "dropbar")

if not present then
  return
end

dropbar.setup{
  bar = {
    pick = {
      pivots = "uiopjklm,;:!"
    }
  }
}
