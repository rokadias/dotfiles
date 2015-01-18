ercn allows for flexible notification rules in ERC. You can
configure it to notify for certain classes of users, query buffers,
certain buffers, etc. It utilizes functions (and a small bit of
copy pasta) from erc-match to get the job done. See the
documentation for `ercn-notify-rules' and `ercn-suppress-rules' to
set it up.

When a notificaiton is needed, ercn calls the ercn-notify hook so
that any notification mechanism available for your system can be
utilized with a little elisp.

History

1.0.0 - Initial release.  It probably even works.

1.0.1 - save-excursion, to avoid messing with the current line

1.0.2 - fix autoloads
