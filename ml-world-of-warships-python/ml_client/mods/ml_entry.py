# coding=utf-8
__author__ = 'Monstrofil'

import imp
import __builtin__
import zlib, base64

import os
import sys

EXT = '.ml'

#===============================================================================
class Base64Importer(object):
    """Служит для поиска и импорта python-модулей, кодированных в base64
    Класс реализует Import Protocol (PEP 302) для вероятности импортирования
    модулей, зашифрованных в base64 из указанного пакета.
    """
    #---------------------------------------------------------------------------
    def __init__(self, root_package_path, root_folder):
        self.root_folder = root_folder
        self.__modules_info = self.__collect_modules_info(root_package_path)
    #---------------------------------------------------------------------------
    def find_module(self, fullname, path=None):
        """Способ будет вызван при импорте модулей
        Если модуль с именем fullname является base64 и находится в заданной
        папке, данный способ вернёт экземпляр импортёра (finder), либо None, если
        модуль не является base64.
        """
        if fullname in self.__modules_info:
            print fullname
            return self
        return None
    #---------------------------------------------------------------------------
    def load_module(self, fullname):
        """Способ загружает base64 модуль
        Если модуль с именем fullname является base64, то способ попытается его
        загрузить. Возбуждает исключение ImportError в случае всякий ошибки.
        """
        if not fullname in self.__modules_info:
            raise ImportError(fullname)
        imp.acquire_lock()
        try:
            mod = sys.modules.setdefault(fullname, imp.new_module(fullname))
            mod.__file__ = "<{}>".format(self.__class__.__name__)
            mod.__loader__ = self
            if self.is_package(fullname):
                mod.__path__ = []
                mod.__package__ = fullname
            else:
                mod.__package__ = fullname.rpartition('.')[0]
            src = self.get_source(fullname)
            try:
                exec src in mod.__dict__
            except Exception, ex:
                del sys.modules[fullname]
                raise ImportError(ex)
        finally:
            imp.release_lock()
        return sys.modules[fullname]
    #---------------------------------------------------------------------------
    def is_package(self, fullname):
        """Возвращает True если fullname является пакетом
        """
        return self.__modules_info[fullname]['ispackage']
    #---------------------------------------------------------------------------
    def get_source(self, fullname):
        """Возвращает начальный код модуля fullname в виде строки
        Способ декодирует начальные коды из base64
        """
        filename = self.__modules_info[fullname]['filename']
        try:
            with file(filename, 'rb') as ifile:
                src = base64.b64decode(zlib.decompress(ifile.read()))
        except IOError:
            src = ''
        return src

    #---------------------------------------------------------------------------
    def __collect_modules_info(self, root_package_path):
        """Собирает информацию о модулях из указанного пакета
        """
        modules = {}
        p = os.path.abspath(root_package_path)
        print p
        dir_name = os.path.dirname(p)
        for root, _, files in os.walk(p):
            # Информация о нынешнем пакете
            filename = os.path.join(root, '__init__' + EXT)
            fullname = root.rpartition(dir_name)[2].replace(os.sep, '.')[1:].replace(self.root_folder +'.', '')
            modules[fullname] = {
                'filename': filename,
                'ispackage': True
            }
            # Информация о модулях в нынешнем пакете
            for f in files:
                if not f.endswith(EXT):
                    continue
                filename = os.path.join(root, f)
                fullfilename = '.'.join([fullname, os.path.splitext(f)[0]])
                modules[fullfilename] = {
                    'filename': filename,
                    'ispackage': False
                }
        return modules

import ResMgr
resModPath = ResMgr.openSection('../paths.xml')['Paths'].values()[1]
relCachePath = resModPath.asString + '/scripts/client'
sys.meta_path.append(Base64Importer(relCachePath, 'client'))

import ml_modules