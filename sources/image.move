module dos_image::image;

use dos_bucket::stored_blob::StoredBlob;
use std::string::String;

public struct Image has key, store {
    id: UID,
    // TODO: Add a validator to validate formats.
    format: String,
    width: Option<u32>,
    height: Option<u32>,
    blob: StoredBlob,
}

public fun new(
    format: String,
    width: Option<u32>,
    height: Option<u32>,
    blob: StoredBlob,
    ctx: &mut TxContext,
): Image {
    Image {
        id: object::new(ctx),
        format: format,
        width: width,
        height: height,
        blob: blob,
    }
}

public fun destroy(self: Image): StoredBlob {
    let Image { id, blob, .. } = self;
    id.delete();

    blob
}

public fun blob(self: &Image): &StoredBlob {
    &self.blob
}

public fun format(self: &Image): &String {
    &self.format
}

public fun height(self: &Image): Option<u32> {
    self.height
}

public fun width(self: &Image): Option<u32> {
    self.width
}
