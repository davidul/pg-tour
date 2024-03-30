# B-Tree
Balanced  data structure
BTree has nodes.
BTree has keys and values. Value is usually a pointer to a record.
Node is equal to a page.

Elements store both key and value - more memory consumption.
Range queries are slow.
B+Tree solved these issues.

B+Tree stores only keys in the nodes. Values are only stored
in leaf nodes. Leaf nodes are linked. Great for range queries.