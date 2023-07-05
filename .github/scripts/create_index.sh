echo '<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Available Resources</title></head><body><h1>Available Resources</h1>'
cd odd
for odd_file in *.odd; do
  if test -f "${odd_file}"; then
    cd ..
    odd_basename=$(basename ${odd_file} '.odd')
    echo "<h2>${odd_file}</h2>"
    if [ -f documentation/${odd_basename}.* ] || [ -f rng/${odd_basename}.* ]; then
      echo "<ul>"
      for resource in documentation/${odd_basename}.* rng/${odd_basename}.*; do
        if test -f "${resource}"; then
          echo '<li><a href="'${resource}'">'${resource}'</a></li>'
        fi
      done
      echo '</ul>'
    fi
  fi
done
echo '</body></html>'
