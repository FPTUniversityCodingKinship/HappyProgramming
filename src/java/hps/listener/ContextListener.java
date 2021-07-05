/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.listener;

import hps.verify.VerifyDTO;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;

/**
 * Web application life-cycle listener.
 *
 * @author Admin
 */
public class ContextListener implements ServletContextListener {

    private final String SITE_MAP_PATH = "/MAPPING/siteMap.map";
    private final String VERIFY_LIST_PATH = "/MAPPING/verify.csv";

    private static List<VerifyDTO> VerifyList;

    private static List<VerifyDTO> getVerifyList(String urlPatterns)
                throws IOException {
        File file = new File(urlPatterns);
        FileReader f = null;
        BufferedReader br = null;

        try {
            if (file.exists()) {
                VerifyList = new ArrayList<>();
                f = new FileReader(urlPatterns);
                br = new BufferedReader(f);

                while (br.ready()) {
                    String line = br.readLine();
                    if (line != null && !line.isEmpty()) {
                        if (line.charAt(0) != '#') {
                            String[] entry = line.split(",", 3);
                            if (!entry[2].isEmpty()) {
                                VerifyDTO dto = new 
                                        VerifyDTO(entry[0], entry[1], entry[2]);
                                VerifyList.add(dto);
                            }
                        }
                    }
                }
                return VerifyList;
            }
        } finally {
            if (br != null) {
                br.close();
            }
            if (f != null) {
                f.close();
            }
        }

        return null;
    }

    private static boolean setVerifyList(String urlPatterns, List<VerifyDTO> verifyList)
                throws IOException {
        File file = new File(urlPatterns);
        FileWriter fw = null;
        PrintWriter pw = null;
        boolean flag = false;

        try {
            if (file.exists() && file.isFile()) {
                file.delete();
            }
            file.createNewFile();

            if (file.exists()) {
                fw = new FileWriter(urlPatterns, true);
                pw = new PrintWriter(fw);

                for (VerifyDTO entry : verifyList) {
                    pw.println(entry.getEmail() + ","
                                + entry.getCode() + ","
                                + entry.getDateTime());
                }
                flag = true;
            }
        } finally {
            if (pw != null) {
                pw.close();
            }
            if (fw != null) {
                fw.close();
            }
        }
        return flag;
    }

    private static Map<String, String> getSiteMap(String urlPatterns)
                throws IOException {
        File file = new File(urlPatterns);
        FileReader f = null;
        BufferedReader br = null;

        Map<String, String> siteMap;
        try {
            if (file.exists()) {
                System.out.println("[ContextListener] file can read.");
                f = new FileReader(urlPatterns);
                br = new BufferedReader(f);
                siteMap = new HashMap<>();

                while (br.ready()) {
                    String line = br.readLine();
                    if (line != null) {

                        if (line.charAt(0) != '#') {
                            String[] entry = line.split("=", 2);
                            if (entry[1] != null)
                                siteMap.put(entry[0].trim(), entry[1].trim());
                        }
                    }
                }
                return siteMap;
            }
        } finally {
            if (br != null) {
                br.close();
            }
            if (f != null) {
                f.close();
            }
        }

        return null;
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //1. assign a hashmap to read siteMapping file.
        Map<String, String> siteMap;
        String filepathMap, filepathMV;
        ServletContext context = sce.getServletContext();

        try {
            if (context != null) {
                filepathMap = context.getRealPath(SITE_MAP_PATH);
                siteMap = getSiteMap(filepathMap);
                filepathMV = context.getRealPath(VERIFY_LIST_PATH);
                getVerifyList(filepathMV);

                // add map of sites into context
                System.out.println("***** SITE MAP *****");
                if (siteMap != null) {
                    System.out.println("[ContextListener] mapping file read successful.");
                    siteMap.keySet().stream().forEach((_key) -> {
                        System.out.println("[" + _key + "]:[" + siteMap.get(_key) + "]");
                    });
                } else {
                    System.out.println("[ContextListener] mapping file read failed.");
                }
                context.setAttribute("SITE_MAP", siteMap);

                // add mail verify code list into context
                System.out.println("***** VERIFY LIST *****");
                if (VerifyList != null) {
                    System.out.println("[ContextListener] verify list read successful.");
                    context.setAttribute("VERIFY_LIST", VerifyList);
                    VerifyList.stream().forEach((_item) -> {
                        System.out.println("[" + _item.getEmail() + "]:[" 
                                    + _item.getCode() + "]");
                    });
                } else {
                    System.out.println("[ContextListener] verify list read failed.");
                }

                // add folder of images into Context
                String rootPath = context.getRealPath("");
                String relativePath = context.getInitParameter("ImageFolder");
                File file = new File(rootPath + File.separator + relativePath);

                //Configure to run directly from the Project's folder with NetBeans
                if (rootPath.contains("build")) {
                    File backup = new File(rootPath + File.separator + ".."
                                + File.separator + ".." + File.separator + "web"
                                + File.separator + relativePath);
                    if (!backup.exists()) {
                        backup.mkdirs();
                    }//end if !backup
                    context.setAttribute("BAK_FILE", backup);
                }//end if rootPath
                if (!file.exists()) {
                    file.mkdirs();
                }//end if !file
                context.setAttribute("DIR_FILE", file);
            }
        } catch (IOException ex) {
            Logger.getLogger(ContextListener.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String filepath;
        String msg = "";

        try {
            if (context != null) {
                // save csv file
                filepath = context.getRealPath(SITE_MAP_PATH);
                VerifyList = (ArrayList) context.getAttribute("VERIFY_LIST");
                if (VerifyList != null) {
                    setVerifyList(filepath, VerifyList);
                    msg = "verifyList write successful. Destination file: " 
                                + filepath;
                }
                else
                    msg = "verifyList write failed. List not found.";
            }
            else
                msg = "null application.";
        } catch (IOException ex) {
            Logger.getLogger(ContextListener.class.getName())
                        .log(Level.SEVERE, null, ex);
        }
        finally {
            System.out.println("[ContextListener] " + msg);
        }
    }
}
