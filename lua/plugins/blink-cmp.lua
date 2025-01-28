return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = {
      -- Allows for a number of typos relative to the length of the query
      -- Set this to 0 to match the behavior of fzf
      max_typos = function(keyword)
        return math.floor(#keyword / 4)
      end,
      -- Frecency tracks the most recently/frequently used items and boosts the score of the item
      use_frecency = true,
      -- Proximity bonus boosts the score of items matching nearby words
      use_proximity = true,
      -- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database. This should only be used on unsupported platforms (i.e. alpine termux)
      use_unsafe_no_lock = false,
      -- Controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
      -- You may pass a function instead of a string to customize the sorting
      sorts = { 'score', 'sort_text' },
      prebuilt_binaries = {
        -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`
        -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
        download = true,
        -- Ignores mismatched version between the built binary and the current git sha, when building locally
        ignore_version_mismatch = false,
        -- When downloading a prebuilt binary, force the downloader to resolve this version. If this is unset
        -- then the downloader will attempt to infer the version from the checked out git tag (if any).
        --
        -- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
        force_version = nil,
        -- When downloading a prebuilt binary, force the downloader to use this system triple. If this is unset
        -- then the downloader will attempt to infer the system triple from `jit.os` and `jit.arch`.
        -- Check the latest release for all available system triples
        --
        -- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
        force_system_triple = nil,
        -- Extra arguments that will be passed to curl like { 'curl', ..extra_curl_args, ..built_in_args }
        extra_curl_args = {},
      },
    },
    keymap = {
      preset = 'default',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
    },
  },
  opts_extend = { 'sources.default' },
}
