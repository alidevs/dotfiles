return {
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async",
      "nvim-neotest/nvim-nio",
    },
    cmd = { "Laravel" },
    event = { "VeryLazy" },
    opts = {},
    config = function()
      require("laravel").setup {
        features = {
          pickers = {
            enable = true,
            provider = 'snacks'
          },
          route_info = {
            enable = true,
          }
        },
        environments = {
          definitions = {
            {
              name = "custom",
              condition = {
                callback = function()
                  return vim.fn.executable("docker") == 1 and vim.fn.filereadable("docker-compose.yml") == 1
                end
              },
              commands = {
                php = { "docker", "compose", "run", "--rm", "php", "php" },
                artisan = { "docker", "compose", "run", "--rm", "artisan" },
                composer = { "docker", "compose", "run", "--rm", "composer" },
              },
            },
          },
          default = "local",
          auto_discover = true,
        },
      }
    end
  },
}
