local TableGen = {}
local ffi = require("ffi")
local cfg = require("table-gen.config")
local utl = require("table-gen.utils")

local function create_cdef(struct_mems, struct_type, struct_size)
    return string.format(
        [[
typedef union
{
    struct
    {
%s
    };
    uint8_t raw[%d];
} __attribute__((__packed__)) %s;
]],
        struct_mems,
        struct_size,
        struct_type
    )
end

local function create_binary(self, filename)
    local file = assert(io.open(filename, "wb"))
    file:write(ffi.string(self.raw, self:size()))
    file:close()
end

local _metatable = {
    __index = {
        create_binary = create_binary,
        size = function(self)
            return ffi.sizeof(self)
        end,
    },
    __tostring = function(self)
        local out, size, fmt = {}, self:size(), cfg._cfg.outfmt
        for i = 0, size - 1 do
            out[#out + 1] = string.format(fmt, self.raw[i])
            out[#out + 1] = ((i + 1) % 8 == 0) and "\n" or " "
        end
        return table.concat(out)
    end,
}

function TableGen.create_struct(struct_data)
    -- TODO
    -- Maintain a repetitive design while in development. I don't quite know
    -- how this will unfold yet. In release, consider putting the following in
    -- a single loop to reduce runtime hit.
    local struct_size = utl._extract_validate_struct_size(struct_data)
    local struct_type = utl._extract_validate_struct_type(struct_data)
    local struct_vals = utl._extract_validate_struct_init(struct_data)
    local struct_mems = utl._extract_validate_struct_mems(struct_data)
    -- INFO
    -- Register cdef w/ ffi registry and create type constructor
    ffi.cdef(create_cdef(struct_mems, struct_type, struct_size))
    return ffi.metatype(ffi.typeof(struct_type), _metatable), struct_vals
end

return TableGen
