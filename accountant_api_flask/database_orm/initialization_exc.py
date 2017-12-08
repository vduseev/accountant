class ModelInitializationError(Exception):
    def __init__(self, errors):
        self.errors = errors

    def to_string(self):
        return 'Errors: ' + '; '.join(self.errors)
