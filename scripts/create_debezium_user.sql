CREATE ROLE dbzuser REPLICATION LOGIN;
ALTER ROLE dbzuser PASSWORD 'dbz';
GRANT ALL PRIVILEGES ON DATABASE chinook TO dbzuser;
CREATE ROLE dbz_rep;
GRANT dbz_rep TO postgres;
GRANT dbz_rep TO dbzuser;
ALTER TABLE public.album OWNER TO dbz_rep;
ALTER TABLE public.artist OWNER TO dbz_rep;
ALTER TABLE public.customer OWNER TO dbz_rep;
ALTER TABLE public.employee OWNER TO dbz_rep;
ALTER TABLE public.genre OWNER TO dbz_rep;
ALTER TABLE public.invoice OWNER TO dbz_rep;
ALTER TABLE public.invoiceline OWNER TO dbz_rep;
ALTER TABLE public.mediatype OWNER TO dbz_rep;
ALTER TABLE public.playlist OWNER TO dbz_rep;
ALTER TABLE public.playlisttrack OWNER TO dbz_rep;
ALTER TABLE public.track OWNER TO dbz_rep;
