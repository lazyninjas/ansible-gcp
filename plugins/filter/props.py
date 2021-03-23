import json 

from datetime import datetime
from ansible.errors import AnsibleFilterError

def read_npm_package(func):
    try:
        pkg_path = '%s/package.json' % func['source_path']
        return json.load(open(pkg_path))
    except Exception as e:
        return None


def append_function_props(func, env):
    pkg = read_npm_package(func) or {}

    if 'version' not in func or not func['version']:
        if 'version' in pkg:
            func['version'] = pkg['version']
        else:
            raise AnsibleFilterError('Function does not specify version and it was not found in any manifest.')

    if env != 'production':
        func['version'] = '%s-%s' % (
            func['version'],
            datetime.now().isoformat(),
        )

    func['artifact_bucket_path'] = 'cf/%s-%s.zip' % (
        func['name'],
        func['version']
    )
    return func


def append_function_list_props(fn_list, env):
    return [append_function_props(fn, env) for fn in fn_list]


class FilterModule(object):
    def filters(self):
        return {
            'gcp_cf_props': append_function_props,
            'gcp_cfs_props': append_function_list_props
        }
